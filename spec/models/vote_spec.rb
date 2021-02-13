require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe '#create' do
    before do
      @electorate = FactoryBot.create(:electorate)
      @candidate = FactoryBot.create(:candidate, electorate_id: @electorate.id)
      @vote = Vote.new(electorate_id: @electorate.id, candidate_id: @candidate.id)
    end
    describe '投票機能' do
      context '投票ができるとき' do
        it 'electorate_id,candidate_idが存在すれば投票できること' do
          expect(@vote).to be_valid
        end
      end
      context '投票ができないとき' do
        it 'electorate_idが空では投票できないこと' do
          @vote.electorate_id = nil
          @vote.valid?
          expect(@vote.errors.full_messages).to include('Electorate must exist', "Electorate can't be blank")
        end
        it 'candidate_idが空では投票できないこと' do
          @vote.candidate_id = nil
          @vote.valid?
          expect(@vote.errors.full_messages).to include('Candidate must exist', "Candidate can't be blank")
        end
        it '一人で２票以上投票できないこと(重複したcandidate_idでは投票できないこと)' do
          @vote.save
          another_vote = Vote.new(electorate_id: @electorate.id, candidate_id: @candidate.id)
          another_vote.valid?
          expect(another_vote.errors.full_messages).to include('Electorate has already been taken')
        end
      end
    end
  end
end
