class VotesController < ApplicationController
  def update
    vote = Vote.find_or_initialize_by(user: current_user)
    vote.assign_attributes(votable: votable, direction: direction)
    vote.save!

    redirect_to :back
  end

  private

  def votable
    votable_id = params["#{params[:votable_type].underscore}_id"]
    params[:votable_type].constantize.find(votable_id)
  end

  def direction
    { 'up' => 1, 'down' => -1 }.fetch(params[:direction])
  end
end
