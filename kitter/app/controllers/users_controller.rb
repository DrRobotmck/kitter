class UsersController < ApplicationController

  before_action :authenticate, only: [:index,:show,:edit,:update,:destroy]
  def index
    @users=User.all
  end

  def show
    @user=User.find(params[:id])
    retweets = @user.retweeted_tweets
    @tweets=(@user.tweets+retweets)
    @tweets = @tweets.sort_by{|t| t.created_at}
    @users=User.all
    @hashtags=Hashtag.all
    @path=@user,Tweet.new
    render :layout => 'user_static'
  end

  def new
    if current_user
      redirect_to current_user, notice: "You already have an account!"
    else
    session[:user_values] ||= {}
    @user=User.new(session[:user_values])
    @user.current_step=session[:user_step]
    end
  end

  def create

    session[:user_values].deep_merge!(params[:user]) if params[:user]
    @user=User.new(session[:user_values])
    @user.current_step=session[:user_step]

    if @user.valid?
      if params[:back_button]
        @user.previous_step
      elsif @user.last_step?
        @user.save! if @user.valid?
      else
        @user.next_step
      end
      session[:user_step]=@user.current_step
    end

    if @user.new_record?
      render 'new'
    else
      session[:user_step] = session[:user_values] = nil
      session[:user_id] = @user.id
      redirect_to @user, notice: "User created. Get kitting!"
    end

  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    @user.update(user_params)
  end

  def destroy
    @user=User.find(params[:id])
    session[@user.id]=nil
    @user.destroy
  end

  def notifications
    @notifications=@user.notifications
  end

  def followers
    @user=User.find(params[:user_id])
    @users=User.all
    @hashtags=Hashtag.all
    @path = @user, Tweet.new
    @followers = @user.followers
    render :layout => 'user_static'
  end

  def following
    @user=User.find(params[:user_id])
    @path = @user, Tweet.new
    @users=User.all
    @followees = @user.followees
    @hashtags=Hashtag.all
    render :layout => 'user_static'
  end

  def favorite_tweets
    @favorites = @user.favorites
    render :layout => 'user_static'
  end

  def follow
    other_user = User.find(params[:user_id])
    current_user.follow(other_user)
    redirect_to other_user, notice: "You are now following #{other_user.username}! Good luck."
  end

  def unfollow
    other_user = User.find(params[:user_id])
    current_user.unfollow(other_user)
    redirect_to other_user, notice: "Congratulations. You have unfollowed #{other_user.username}."
  end

  def block
    other_user = User.find(params[:user_id])
    current_user.block(other_user)
    redirect_to other_user, notice: "You have blocked #{other_user.username}, finally."
  end

  def unblock
    other_user = User.find(params[:user_id])
    current_user.unblock(other_user)
    redirect_to other_user, notice: "You have unblocked #{other_user.username}! Good to see you two getting back together."
  end

  private
  def user_params
    params.require(:user).permit(:username, :name, :email, :bio, :website, :verified, :location, :password, :password_confirmation, :country_id,:profile_photo_url, :background_photo_url)
  end

end
