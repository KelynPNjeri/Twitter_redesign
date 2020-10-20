# frozen_string_literal: true

class RepliesController < ApplicationController
  def new
    @reply = Reply.find(params[:id])
  end

  def create
    @reply = Reply.new(reply_params)
    @reply.tweet_id = params[:tweet_id]
    @reply.user = current_user

    if @reply.save
      redirect_to request.referrer, notice: 'reply was successfully created.'
    else
      redirect_to request.referrer, alert: @reply.errors.full_messages.join('. ').to_s
    end
  end

  def destroy
    @reply = Reply.find(params[:id])

    @reply.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:content)
  end
end
