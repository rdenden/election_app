require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    before do
      @message = FactoryBot.build(:message)
      
    end

    it 'contentが存在していれば保存できること' do
      expect(@message).to be_valid
    end

    it 'roomが紐付いていないと保存できないこと' do
      @message.room = nil
      @message.valid?
      expect(@message.errors.full_messages).to include('Room must exist')

    end

    it 'electorateが紐付いていないと保存できないこと' do
      @message.electorate = nil
      @message.valid?
      expect(@message.errors.full_messages).to include('Electorate must exist')

    end
  end
end
