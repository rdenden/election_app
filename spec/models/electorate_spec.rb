require 'rails_helper'

RSpec.describe Electorate, type: :model do
  describe '#create' do
    before do
      @electorate = FactoryBot.build(:electorate)
    end

    describe '有権者登録' do
      context '登録がうまくいくとき' do
        it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること' do
          expect(@electorate).to be_valid
        end
      end
      context '登録がうまくいかないとき' do
        it 'nameが空では登録できないこと' do
          @electorate.nickname = nil
          @electorate.valid?
          expect(@electorate.errors.full_messages).to include("Nickname can't be blank")
        end
        it 'emailが空では登録できないこと' do
          @electorate.email = nil
          @electorate.valid?
          expect(@electorate.errors.full_messages).to include("Email can't be blank")
        end

        it 'passwordが空では登録できないこと' do
          @electorate.password = nil
          @electorate.valid?
          expect(@electorate.errors.full_messages).to include("Password can't be blank")
        end
      end
    end
  end
end
