class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @candidate = Candidate.find(params[:candidate_id])

    if @message.save
      redirect_to candidate_room_path(@candidate, @candidate.room)
    else
      @candidate_messages = Message.where(room_id: @candidate.room, electorate_id: @candidate.electorate)
      @electorate_messages = Message.where(room_id: @candidate.room).where.not(electorate_id: @candidate.electorate)
      render template: 'rooms/show'
    end
  end

  private

  def message_params
    params.permit(:content, :room_id).merge(electorate_id: current_electorate.id)
  end
end
