class TopsController < ApplicationController
  def index
    vote_time = Time.local 2021, 1, 5, 20, 0, 0
    now = Time.now
    if vote_time < now
      @candidates = Candidate.all
    else redirect_to votes_path
    end
  end
end
