class MainController<ApplicationController

  def welcome
    @user=current_user
    users= User.all
    users = users.each.reject {|user| @user.followers.include?(user)}
    @users=users.sample(3)
    @hashtags=Hashtag.all
    @tweets=Tweet.all
    @tweet=Tweet.new
    @path=[@user,@tweet]
  end

end
