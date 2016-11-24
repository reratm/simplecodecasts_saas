class ProfilesController < ApplicationController
  
  #before_action it's mean that its run before any of next actions (before new, before create...)
  before_action :authenticate_user! #devise gem thing to protect from changing profile by un-authenticate users
  before_action :only_current_user #devise gem thing to protect from cross-users profile editing, additional we difine it in private section below
  
  def new
    # form where a user can fill out their own profile.
    @user = User.find( params[:user_id] )
    @profile = Profile.new
  end
  
  def create 
    @user = User.find( params[:user_id] )
    @profile = @user.build_profile(profile_params) #create profile via gem devise
    if @profile.save
      flash[:success] = "Profile Updated!"
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end
  
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  def update
    @user = User.find( params[:user_id] )
    @profile = @user.profile #open current user's profile
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile Updated!"
      redirect_to user_path( params[:user_id] ) # redirecting to users own page
    else
      render action: :edit #go back to edit page
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to(root_url) unless @user == current_user
    end
    
end