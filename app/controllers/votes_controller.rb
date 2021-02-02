class VotesController < ApplicationController
  def new
    if current_electorate.vote
      redirect_to root_path
    end
    @candidates = Candidate.all
    @vote = Vote.new
  end
  def create
    if params[:vote] == nil
      @candidates = Candidate.all
      @vote = Vote.new
      render :new
    else
      @vote = Vote.new(vote_params)
      if @vote.valid?
        @vote.save        
        redirect_to root_path
    
      else
        @candidates = Candidate.all
        render :new
      
      end
    end 
  end

  def index
    @candidates = Candidate.all
    counts = Vote.group(:candidate_id).count(:candidate_id)
    @values = counts.values
    @candidate = Candidate.find(counts.key(counts.values.max))
    
  
  
  end
  private
  def vote_params
    params.require(:vote).permit(:candidate_id).merge(electorate_id: current_electorate.id)
    
  end
   
   
end
