require 'rails_helper'

RSpec.describe "Messages", type: :system do
  before do
    @electorate = FactoryBot.create(:electorate)
    @electorate1 = FactoryBot.create(:electorate)
    @candidate = FactoryBot.build(:candidate)
    @candidate1 = FactoryBot.create(:candidate, electorate_id: @electorate1.id)
    @message = FactoryBot.build(:message)
    @room1 = FactoryBot.create(:room, candidate_id: @candidate1.id)
  end

  context 'メッセージが投稿できるとき'do
    it 'ログインした有権者は投稿できる' do
      # ログインしてトップページに遷移する
      visit new_electorate_session_path
      fill_in 'メールアドレス', with: @electorate.email
      fill_in 'パスワード（6文字以上）', with: @electorate.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 立候補者1ページに遷移する
      visit candidate_path(@candidate1)
      # ルームへのリンクがあることを確認する
      expect(page).to have_link"#{@candidate1.last_name}#{@candidate1.first_name}候補への質問はこちらへ"
      # 立候補者1のルームへ遷移する
      visit candidate_room_path(@candidate1,@candidate1.room)
      # メッセージを送信するとメッセージのカウントが1上がる
      fill_in 'content', with: @message
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)
    end
  end

  context 'メッセージが投稿できない時'do
    it 'ログインしていないと投稿できない' do
      # 立候補者1ページに遷移する
      visit candidate_path(@candidate1)
      # ルームへのリンクがないことを確認する
      expect(page).to have_no_link"#{@candidate1.last_name}#{@candidate1.first_name}候補への質問はこちらへ"
    end
  end
end
