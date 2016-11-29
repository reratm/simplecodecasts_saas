class UsersController < ApplicationController
  
  before_action :authenticate_user! #devise gem thing to protect from un-authenticate users
  
  def index
  end
  
  def show
    @user = User.find( params[:id] )
  end
end