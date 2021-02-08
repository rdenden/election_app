require 'rails_helper'

RSpec.describe "Candidates", type: :system do
  before do
    @electorate1 = FactoryBot.create(:electorate)
    @electorate2 = FactoryBot.create(:electorate)
    @candidate2 = FactoryBot.create(:candidate, electorate_id: @electorate2.id)

  end
  context '投票ができるとき'do
    it 'ログインした有権者は投票できる' do
      # ログインしてトップページに遷移する
      visit new_electorate_session_path
      fill_in 'メールアドレス', with: @electorate1.email
      fill_in 'パスワード（6文字以上）', with: @electorate1.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 「投票する」のボタンがあることを確認する
      expect(page).to have_content('投票する')
      # 投票ページに移動する
      visit new_vote_path
      # ラジオボタンから候補者2を選択    
      choose "vote_candidate_id_#{@candidate2.id}"
      # 送信するとCandidateモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Vote.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      
      
    end
  end
  context '投票ができないとき'do
    it 'ログインしていないと投票ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 立候補ボタンがない
      expect(page).to have_no_content('投票する')
    end
    it '投票済みの有権者は重ねて投票することはできない' do
      # ログインしてトップページに遷移する
      visit new_electorate_session_path
      fill_in 'メールアドレス', with: @electorate1.email
      fill_in 'パスワード（6文字以上）', with: @electorate1.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 「投票する」のボタンがあることを確認する
      expect(page).to have_content('投票する')
      # 投票ページに移動する
      visit new_vote_path
      # ラジオボタンから候補者2を選択    
      choose "vote_candidate_id_#{@candidate2.id}"
      # 送信するとCandidateモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Vote.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # 「投票する」のボタンがないことを確認する
      expect(page).to have_no_content('投票する')
    end
  end
end