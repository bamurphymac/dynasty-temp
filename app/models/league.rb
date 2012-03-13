class League < ActiveRecord::Base
    self.table_name = 'dynasty_leagues'

    extend FriendlyId
    friendly_id :name, :use => :slugged
    money :default_balance, :cents => :default_balance_cents, :precision => 0

    #TODO: Create views, access control for users, associate league standings, schedules, and trades for user_teams
    has_many :teams, :class_name => 'UserTeam'
    has_many :users, :through => :teams
    has_many :drafts
    has_many :players, :through => :teams
    has_many :player_team_records, :through => :teams
    has_many :player_team_records
    #  requires :attribute, :name, :size
    belongs_to :manager, :class_name => 'User', :inverse_of => :leagues
    belongs_to :clock, :inverse_of => :leagues

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

    # gets the active draft (if any)
    def draft
        self.drafts.first
    end

    def is_public?; self.public === true end
    def is_private?; !(is_public?) end
end
