class TweetsController < ApplicationController

  before_action :authenticate

  def index
    @tweets=Tweet.all
  end

  def show
    @tweet=Tweet.find(params[:id])

  end

  def new
    @user=User.find(params[:user_id])
    @tweet=Tweet.new
    @path=[@user,@tweet]
  end

  def create
    @tweet=Tweet.new
    @user=User.find(params[:user_id])
    @path=[@user,@tweet]
    content = @tweet.scan_tweet(tweet_params[:content])
    @tweet.update(content: content, user: @user)
    if @tweet.save
      redirect_to tweet_path(@tweet), notice: "Successfully created!"
    else
      flash[:notice]="Please correct the following errors:"
      render 'new'
    end
  end

  def favorite
    @tweet=Tweet.find(params[:tweet_id])
    current_user.favorite(@tweet)
    redirect_to @tweet, notice: 'favorited'
  end

  def retweet
    @tweet=Tweet.find(params[:tweet_id])
    current_user.retweet(@tweet)
    redirect_to @tweet, notice: 'retweeted'
  end

  def destroy
    @tweet=Tweet.find(params[:id])
    @user=@tweet.user
    @tweet.destroy
    redirect_to @user
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
