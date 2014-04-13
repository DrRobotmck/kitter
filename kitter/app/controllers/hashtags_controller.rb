class HashtagsController < ApplicationController

  def index
    @hashtags = Hashtag.all
  end

  def show
    @hashtag=Hashtag.find_by(content: params[:hashtag])
  end

end
