class TopsController < ApplicationController
  
  def index
    
    @candidates = Candidate.all
  end
end
