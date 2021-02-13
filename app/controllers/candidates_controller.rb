class CandidatesController < ApplicationController
  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    @room = @candidate.build_room

    if @candidate.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @candidate = Candidate.find(params[:id])
  end

  def edit
    @candidate = Candidate.find(params[:id])
  end

  def update
    @candidate = Candidate.find(params[:id])
    if @candidate.update(candidate_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @candidate = Candidate.find(params[:id])
    if current_electorate.id == @candidate.electorate_id
      if @candidate.destroy
        redirect_to root_path
      else
        render :edit
      end
    end
  end

  private

  def candidate_params
    params.require(:candidate).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date, :age,
                                      :birth_place, :gender_id, :political_party, :experience_id, :occupation, :education, :career, :public_commitment, :image).merge(electorate_id: current_electorate.id)
  end
end
