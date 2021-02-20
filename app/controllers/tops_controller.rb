class TopsController < ApplicationController
  def index
    vote_time = Time.local 2021, 1, 5, 20, 0, 0
    now = Time.now
    if vote_time < now
      @candidates = Candidate.all
      # 投票締め切り後は投票結果のページに飛ばされる
    else redirect_to votes_path
    end
  end
end
