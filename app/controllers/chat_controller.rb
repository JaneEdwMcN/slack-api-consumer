class ChatController < ApplicationController
  def index
    @channels = SlackApiWrapper.list_channels
  end

  def new
    @channel = params[:channel]
  end

  def create
    if SlackApiWrapper.send_msg(params[:channel], params[:message])
      flash[:status] = :success
      flash[:result_text] = "You just posted to #{params[:channel]}!"
      redirect_to root_path
    else
      flash[:status] = :danger
      flash[:result_text] = "Failed to post to #{params[:channel]}."
      render :new
    end
  end

end
