class League < ActiveRecord::Base
    self.table_name = 'dynasty_leagues'

    extend FriendlyId
    friendly_id :name, :use => :slugged
    money :default_balance, :cents => :default_balance_cents, :precision => 0
    money :balance, :cents => :balance_cents

    alias_attribute :team_count, :user_teams_count

    #TODO: Create views, access control for users, associate league standings, schedules, and trades for user_teams
    has_many :teams, :class_name => 'UserTeam'
    has_many :users, :through => :teams
    has_many :drafts
    has_many :players, :through => :teams
    has_many :player_team_records, :through => :teams
    has_many :player_team_records
    has_many :games
    #  requires :attribute, :name, :size
    belongs_to :manager, :class_name => 'User', :inverse_of => :leagues
    belongs_to :clock, :inverse_of => :leagues
    has_many :payments, :as => :receivable
    has_many :receipts, :as => :payable

    validates_presence_of :name, :size
    validates_uniqueness_of :name
    validates_format_of :name, :with => /^[[:alnum:] ]+$/, :on => :create
    validates_inclusion_of :size, :in => Settings.league.capacity
    validates_length_of :password,
        :minimum => Settings.league.password_min_length,
        :maximum => Settings.league.password_max_length,
        :if => lambda{ |league| league.is_private? }

    scope :with_manager, joins{ manager }.includes{ manager }
    scope :with_teams, joins{ teams }.includes{ teams }
    scope :filter_by_name, lambda{ |league_name|
        where{ name =~ "#{league_name}%" }
    }

    def calculate_game_points(from, to)
        weeks = ((to.to_date - Season.current.start_date) / 7).to_i
        games = Game.where{ (league_id == my{ id }) & (week >> my{ weeks }) }
            .where{ (home_team_score == nil) & (away_team_score == nil) }
        games.each do |game|
            #force_starters game.away_team
            #force_starters game.home_team
            game.home_team_score = points_for_team game.home_team, from, to
            game.away_team_score = points_for_team game.away_team, from, to
            game.save
        end
        return
        self.teams.each do |team|
=begin
=end
            points = points_for_team(team, from, to)

            game = Game.new :team_id => team.id, :week => self.clock.week, :points => (points ? points : 0)
            if game.save!
                schedule = team.schedules.where('week = ?', self.clock.week).first
                schedule.team_score = team.games.where('week = ?', self.clock.week).first.points
                schedule.opponent_score = UserTeam.find(schedule.opponent_id).games.where('week = ?', self.clock.week).first.points
                schedule.outcome = 1 if schedule.team_score > schedule.opponent_score
                schedule.outcome = 0 if schedule.team_score < schedule.opponent_score
                schedule.save

                # calculate win/loss payouts
                winnings = schedule.outcome == 1 ? Settings.game.winning_payout : Settings.game.losing_payout
                self.game = team.games.where('week = ?', self.clock.week).first
                self.game.winnings = winnings
                self.game.save
                team.balance += self.game.winnings.to_money
                team.save
            end
        end
    end

    def points_for_team(team, from, to)
        starter_points = PlayerEventPoint.select{ sum(points).as('points') }
            .joins{[ event, player.team_link.team ]}
            .where{ player.team_link.team.id == my{ team.id } }
            .where{ player.team_link.depth == 1 }
            .where{ (event.start_date_time >= from) & (event.start_date_time < to) }
            .first.points
        bench_points = PlayerEventPoint.select{ sum(points).as('points') }
            .joins{[ event, player.team_link.team ]}
            .where{ player.team_link.team.id == my{ team.id } }
            .where{ player.team_link.depth == 0 }
            .where{ (event.start_date_time >= from) & (event.start_date_time < to) }
            .first.points
        starter_points.to_f + (bench_points.to_f / 3)
    end

    # TODO: move this into the team model
    def force_starters(team)
        continue unless team.id == 5
        # force empty player slots to be filled
        Lineup.reflect_on_association(:player_teams).options[:conditions] = "#{PlayerTeamRecord.table_name}.user_team_id = #{team.id}"
        empty_slots = Lineup.joins{[ position, player_teams.outer, player_teams.position.outer ]}
            .includes{[ position, player_teams.position ]}
            .where{ player_teams.player_id == nil }
        empty_slots.each do |slot|
            team_player = PlayerTeamRecord.select("#{PlayerTeamRecord.table_name}.*")
                .joins{[ player.position_link, player.points ]}
                .where{ (user_team_id == my{ team.id }) & (lineup_id == nil) }
                .order{ player.points.points.desc }
            if slot.flex
                team_player = team_player.where{ player.position_link.position_id >> my{ slot.position.positions.collect{ |x| x.id } } }
            else
                team_player = team_player.where{ player.position_link.position_id == slot.position_id }
            end
            team_player = team_player.first
            if team_player
                team_player.lineup_id = slot.id
                team_player.depth = 1 # TODO: remove this when depth doesn't matter anymore
                team_player.save
            end
        end
    end

    # gets the active draft (if any)
    def draft
        self.drafts.first
    end

    def is_public?; self.public === true end
    def is_private?; !(is_public?) end
end
