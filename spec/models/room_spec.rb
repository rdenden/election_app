require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#create' do
    before do
      @room = FactoryBot.build(:room)
    end

    it 'candidateが存在していれば保存できること' do
      expect(@room).to be_valid
    end

    it 'candidateが紐付いていないと保存できないこと' do
      @room.candidate = nil
      @room.valid?
      expect(@room.errors.full_messages).to include('Candidate must exist')
    end
  end
end
