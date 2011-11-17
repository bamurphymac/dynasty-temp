class ApplicationController < ActionController::Base
  #protect_from_forgery :except => [ :auth, :post_message ]
  before_filter :authenticate_user!

  layout 'application'

  private
  	def user_not_authorized
  		render :text => 'You are not authorized for this action.', :status => 401
	  end
end
