class MainController<ApplicationController

  def welcome
    @user=current_user
    users= User.all
    users = users.each.reject {|user| @user.followers.include?(user)}
    @users=users.sample(3)
    @hashtags=Hashtag.all.sample(10)
    @tweets=Tweet.all.sort_by {|tweet| tweet.updated_at}
    @tweet=Tweet.new
    @path=[@user,@tweet]
  end

end
