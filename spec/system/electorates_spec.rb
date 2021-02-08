require 'rails_helper'

RSpec.describe "有権者登録", type: :system do
  before do
    @electorate = FactoryBot.build(:electorate)
  end

  context '有権者登録ができるとき' do 
    it '正しい情報を入力すれば有権者登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するリンクがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_electorate_registration_path
      # ユーザー情報を入力する
      fill_in 'メールアドレス', with: @electorate.email
      fill_in 'パスワード（6文字以上）', with: @electorate.password
      fill_in 'パスワード再入力', with: @electorate.password_confirmation
      fill_in 'ユーザー名', with: @electorate.nickname
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Electorate.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # トップページにログアウト、投票する、選挙結果を見る、のボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      expect(page).to have_content('投票する')
      expect(page).to have_content('選挙結果を見る')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context '有権者登録ができないとき' do
    it '誤った情報では有権者登録ができずに有権者登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するリンクがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_electorate_registration_path
      # ユーザー情報を入力する
      fill_in 'メールアドレス', with: ""
      fill_in 'パスワード（6文字以上）', with: ""
      fill_in 'パスワード再入力', with: ""
      fill_in 'ユーザー名', with: ""
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Electorate.count }.by(0)
      # 有権者登録ページへ戻されることを確認する
      expect(current_path).to eq "/electorates"
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @electorate = FactoryBot.create(:electorate)
  end
  context 'ログインができるとき' do
    it '保存されている有権者の情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_electorate_session_path
      # 正しいユーザー情報を入力する
      fill_in 'メールアドレス', with: @electorate.email
      fill_in 'パスワード（6文字以上）', with: @electorate.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # トップページにログアウト、投票する、選挙結果を見る、のボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      expect(page).to have_content('投票する')
      expect(page).to have_content('選挙結果を見る')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_electorate_registration_path
      # ユーザー情報を入力する
      fill_in 'メールアドレス', with: ""
      fill_in 'パスワード（6文字以上）', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq "/electorates"

    end
  end
end