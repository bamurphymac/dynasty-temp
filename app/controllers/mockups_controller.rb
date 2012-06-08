class MockupsController < ApplicationController

  def index
    @title = "Mockups Index"
  end

  def user_control_panel
    @title = "User Control Panel"
  end

  def team_control_panel
    @title = "Team Control Panel"
  end

  def league_review
    @title = "League Review"
    @teams = current_user.team.league.teams.all
    @teams.sort!{|a, b| b.rating <=> a.rating }
    @games = Game.where(:league_id => current_user.team.league_id)
    @game_weeks = @games.group_by {|g| g.date}
  end


  def login
    @title = "Login Mockup"
  end

  def signup
    @title = "New User Signup"
  end

  def signup_2
    @title = "New User Signup"
  end

  def signup_3
    @title = "New User Signup"
  end

  def signup_4
    @title = "Choose League"
  end

  def signup_5
    @title = "Choose League"
  end



  def purchase_dynasty_dollars
    @title = "Purchase Dynasty Dollars"
  end

  def team_marketplace
    @title = "Team Marketplace"
  end

  def purchase_team
    @title = "Purchase Team"
  end

  def sell_team
    @title = "Sell Team"
  end

  def confirm_team_purchase
    @title = "Confirm Team Puchase"
  end

  def confirm_team_sale
    @title = "Confirm Team Sale"
  end



  def create_team
    @title = "Create A Team"
  end

  def player_research
    @title = "Player Research"
  end

  def player_detail
    @title = "Player Detail"
  end

  def player_news
    @title = "Player News"
  end

  def headlines
    @title = "Headlines"
  end

  def transactions_contracts
    @title = "Transactions & Contracts"
  end

  def depth_charts
    @title = "Depth Charts"
  end

  def featured_articles
    @title = "Featured Articles"
  end

  def privacy
    @title = "Privacy Policy"
  end

  def terms_conditions
    @title = "Terms & Conditions"
  end

  def faq
    @title = "FAQ"
  end

  def rules
    @title = "Rules"
  end

  def how_to_play
    @title = "How to Play"
  end

  def contact
    @title = "Contact Us"
  end

  def new_team
    @title = "Create a Team"
  end
end
