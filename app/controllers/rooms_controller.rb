class RoomsController < ApplicationController
  def show
    @candidate = Candidate.find(params[:candidate_id])
    @room = @candidate.room
    @message = Message.new
    @candidate_messages = Message.where(room_id: @candidate.room, electorate_id: @candidate.electorate)
    @electorate_messages = Message.where(room_id: @candidate.room).where.not(electorate_id: @candidate.electorate)  
  end
end
