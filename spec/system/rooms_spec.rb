require 'rails_helper'

RSpec.describe "ルームの生成", type: :system do
    before do
      @electorate = FactoryBot.create(:electorate)
      @candidate = FactoryBot.build(:candidate)
    end
    
    context 'ルームが生成できるとき'do
    it '立候補できるすれば自動的に生成される' do
      # ログインしてトップページに遷移する
      visit new_electorate_session_path
      fill_in 'メールアドレス', with: @electorate.email
      fill_in 'パスワード（6文字以上）', with: @electorate.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 「立候補する」のボタンがあることを確認する
      expect(page).to have_content('立候補する')
      # 立候補ページに移動する
      visit new_candidate_path
      # フォームに情報を入力する
      # find('input[type="file"]').click
      # attach_file('candidate[image]','public/images/sample.jpg' , make_visible: true)
      fill_in 'last-name', with: @candidate.last_name
      fill_in 'first-name', with: @candidate.first_name
      fill_in 'last-name-kana', with: @candidate.last_name_kana
      fill_in 'first-name-kana', with: @candidate.first_name_kana
      select '2000',from: 'candidate[birth_date(1i)]'
      select '1',from: 'candidate[birth_date(2i)]'
      select '1',from: 'candidate[birth_date(3i)]'
      fill_in 'age', with: @candidate.age
      select '男',from: 'candidate[gender_id]'      
      fill_in 'birth-place', with: @candidate.birth_place
      fill_in 'occupation', with: @candidate.occupation
      fill_in 'education', with: @candidate.education
      fill_in 'political-party', with: @candidate.political_party
      select '新人',from: 'candidate[experience_id]'
      fill_in 'career', with: @candidate.career
      fill_in 'public-commitment', with: @candidate.public_commitment
      # 送信するとCandidateモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Room.count }.by(1)
    end
  end
end






   