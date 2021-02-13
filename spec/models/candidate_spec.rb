require 'rails_helper'

RSpec.describe Electorate, type: :model do
  describe '#create' do
    before do
      @electorate = FactoryBot.create(:electorate)
      @candidate = FactoryBot.build(:candidate, electorate_id: @electorate.id)
    end

    describe '候補者登録' do
      context '立候補ができるとき' do
        it 'last_name,first_name,last_name_kana,first_name_kana,birth_date,age,birth_place,gender_id,political_party,expelience_id,occupation,education,electorate_idが存在すれば登録できること' do
          expect(@candidate).to be_valid
        end
      end
      context '立候補ができないとき' do
        it 'last_nameが空では登録できないこと' do
          @candidate.last_name = nil
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include("Last name can't be blank",
                                                             'Last name Full-width characters')
        end
        it 'first_nameが空では登録できないこと' do
          @candidate.first_name = nil
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include("First name can't be blank",
                                                             'First name Full-width characters')
        end
        it 'last_name_kanaが空では登録できないこと' do
          @candidate.last_name_kana = nil
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include("Last name kana can't be blank",
                                                             'Last name kana Full-width katakana characters')
        end
        it 'first_name_kanaが空では登録できないこと' do
          @candidate.last_name_kana = nil
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include("Last name kana can't be blank",
                                                             'Last name kana Full-width katakana characters')
        end
        it 'birth_dateが空では登録できないこと' do
          @candidate.birth_date = nil
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include("Birth date can't be blank")
        end
        it 'ageが空では登録できないこと' do
          @candidate.age = nil
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include("Age can't be blank")
        end
        it 'birth_placeが空では登録できないこと' do
          @candidate.birth_place = nil
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include("Birth place can't be blank")
        end
        it 'gender_idが空では登録できないこと' do
          @candidate.gender_id = nil
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include("Gender can't be blank")
        end
        it 'political_partyが空では登録できないこと' do
          @candidate.political_party = nil
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include("Political party can't be blank")
        end
        it 'experience_idが空では登録できないこと' do
          @candidate.experience_id = nil
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include("Experience can't be blank")
        end
        it 'occupationが空では登録できないこと' do
          @candidate.occupation = nil
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include("Occupation can't be blank")
        end
        it 'educationが空では登録できないこと' do
          @candidate.education = nil
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include("Education can't be blank")
        end
        it 'electorate_idが空では登録できないこと' do
          @candidate.electorate_id = nil
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Electorate must exist', "Electorate can't be blank")
        end
        it 'last_nameが全角英字で登録できないこと' do
          @candidate.last_name = 'ａａ'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Last name Full-width characters')
        end

        it 'last_nameが全角数字で登録できないこと' do
          @candidate.last_name = '１１'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Last name Full-width characters')
        end
        it 'first_nameが全角英字で登録できないこと' do
          @candidate.first_name = 'ａａ'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('First name Full-width characters')
        end

        it 'first_nameが全角数字で登録できないこと' do
          @candidate.first_name = '１１'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('First name Full-width characters')
        end

        it 'last_name_kanaが全角英字で登録できないこと' do
          @candidate.last_name_kana = 'ａａ'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Last name kana Full-width katakana characters')
        end

        it 'last_name_kanaが全角数字で登録できないこと' do
          @candidate.last_name_kana = '１１'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Last name kana Full-width katakana characters')
        end

        it 'first_name_kanaが全角英字で登録できないこと' do
          @candidate.first_name_kana = 'ａａ'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('First name kana Full-width katakana characters')
        end

        it 'first_name_kanaが全角数字で登録できないこと' do
          @candidate.first_name_kana = '１１'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('First name kana Full-width katakana characters')
        end

        it 'first_nameが半角英字で登録できないこと' do
          @candidate.first_name = 'aa'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('First name Full-width characters')
        end

        it 'first_nameが半角数字で登録できないこと' do
          @candidate.first_name = '11'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('First name Full-width characters')
        end

        it 'last_name_kanaが半角英字で登録できないこと' do
          @candidate.last_name_kana = 'aaa'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Last name kana Full-width katakana characters')
        end

        it 'last_name_kanaが半角数字で登録できないこと' do
          @candidate.last_name_kana = '111'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Last name kana Full-width katakana characters')
        end

        it 'first_name_kanaが半角英字で登録できないこと' do
          @candidate.first_name_kana = 'aaa'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('First name kana Full-width katakana characters')
        end

        it 'first_name_kanaが半角数字で登録できないこと' do
          @candidate.first_name_kana = '111'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('First name kana Full-width katakana characters')
        end

        it 'last_name_kanaが漢字で登録できないこと' do
          @candidate.last_name_kana = '阿'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Last name kana Full-width katakana characters')
        end

        it 'last_name_kanaがひらがなで登録できないこと' do
          @candidate.last_name_kana = 'あ'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Last name kana Full-width katakana characters')
        end
        it 'first_name_kanaが漢字で登録できないこと' do
          @candidate.first_name_kana = '阿'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('First name kana Full-width katakana characters')
        end
        it 'first_name_kanaがひらがなで登録できないこと' do
          @candidate.first_name_kana = 'あ'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('First name kana Full-width katakana characters')
        end
        it 'ageが全角では登録できないこと' do
          @candidate.age = '１'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Age is not a number')
        end
        it 'ageが英字では登録できないこと' do
          @candidate.age = 'a'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Age is not a number')
        end
        it 'ageが24以下では登録できないこと' do
          @candidate.age = '24'
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Age must be greater than or equal to 25')
        end
        it 'gender_idが0では登録できないこと' do
          @candidate.gender_id = 0
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Gender must be other than 0')
        end
        it 'experience_idが0では登録できないこと' do
          @candidate.experience_id = 0
          @candidate.valid?
          expect(@candidate.errors.full_messages).to include('Experience must be other than 0')
        end
        it '同一有権者が重ねて立候補できないこと(electorate_idの重複は認められないこと)' do
          @candidate.save
          another_candidate = FactoryBot.build(:candidate, electorate_id: @electorate.id)
          another_candidate.valid?
          expect(another_candidate.errors.full_messages).to include('Electorate has already been taken')
        end
      end
    end
  end
end
