require 'rails_helper'

RSpec.describe '立候補機能', type: :system do
  before do
    @electorate = FactoryBot.create(:electorate)
    @electorate1 = FactoryBot.create(:electorate)
    @candidate = FactoryBot.build(:candidate)
    @candidate1 = FactoryBot.create(:candidate, electorate_id: @electorate1.id)
    @candidate.career = Faker::Lorem.sentence
    @candidate.public_commitment = Faker::Lorem.sentence
  end
  context '立候補ができるとき' do
    it 'ログインした有権者は立候補できる' do
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
      select '2000', from: 'candidate[birth_date(1i)]'
      select '1', from: 'candidate[birth_date(2i)]'
      select '1', from: 'candidate[birth_date(3i)]'
      fill_in 'age', with: @candidate.age
      select '男', from: 'candidate[gender_id]'
      fill_in 'birth-place', with: @candidate.birth_place
      fill_in 'occupation', with: @candidate.occupation
      fill_in 'education', with: @candidate.education
      fill_in 'political-party', with: @candidate.political_party
      select '新人', from: 'candidate[experience_id]'
      fill_in 'career', with: @candidate.career
      fill_in 'public-commitment', with: @candidate.public_commitment
      # 送信するとCandidateモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Candidate.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # 「立候補する」のボタンがないことを確認する
      expect(page).to have_no_content('立候補する')
      # トップページには先ほど登録した候補者の画像が存在することを確認する（画像）
      # トップページには先ほど登録した候補者の名前のリンクが存在することを確認する（テキスト）
      expect(page).to have_content(@candidate.last_name)
      expect(page).to have_content(@candidate.first_name)
    end
  end
  context '立候補ができないとき' do
    it 'ログインしていないと立候補ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 立候補ボタンがない
      expect(page).to have_no_content('立候補する')
    end
    it '立候補済みの有権者は重ねて立候補することはできない' do
      # 立候補済みの有権者でログインしてトップページに遷移する
      visit new_electorate_session_path
      fill_in 'メールアドレス', with: @electorate1.email
      fill_in 'パスワード（6文字以上）', with: @electorate1.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 立候補ボタンがない
      expect(page).to have_no_content('立候補する')
    end
  end
end

RSpec.describe '立候補情報の編集', type: :system do
  before do
    @electorate1 = FactoryBot.create(:electorate)
    @electorate2 = FactoryBot.create(:electorate)
    @candidate1 = FactoryBot.create(:candidate, electorate_id: @electorate1.id)
    @candidate2 = FactoryBot.create(:candidate, electorate_id: @electorate2.id)
    @room1 = Room.create(candidate_id: @candidate1.id)
    @room2 = Room.create(candidate_id: @candidate2.id)
    @candidate1.birth_date = '2000-12-12'
  end
  context '立候補情報の編集ができるとき' do
    it 'ログインした有権者は自分の立候補情報の編集ができる' do
      # 立候補者１である有権者でログインする
      visit new_electorate_session_path
      fill_in 'メールアドレス', with: @electorate1.email
      fill_in 'パスワード（6文字以上）', with: @electorate1.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      expect(page).to have_content(@candidate1.last_name)
      expect(page).to have_content(@candidate1.first_name)
      # 立候補者ページに遷移し「プロフィールを編集する」ボタンがあることを確認する
      visit candidate_path(@candidate1.id)
      expect(page).to have_link 'プロフィールを編集する', href: edit_candidate_path(@candidate1)
      # 編集ページへ遷移する
      visit edit_candidate_path(@candidate1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      # expect(
      # find('#tweet_image').value
      # ).to eq @tweet1.image
      expect(
        find('#last-name').value
      ).to eq @candidate1.last_name
      expect(
        find('#first-name').value
      ).to eq @candidate1.first_name
      expect(
        find('#last-name-kana').value
      ).to eq @candidate1.last_name_kana
      expect(
        find('#first-name-kana').value
      ).to eq @candidate1.first_name_kana
      expect(
        find('#candidate_birth_date_1i').value
      ).to eq '2000'
      expect(
        find('#candidate_birth_date_2i').value
      ).to eq '12'
      expect(
        find('#candidate_birth_date_3i').value
      ).to eq '12'
      expect(
        find('#age').value
      ).to eq '25'
      expect(
        find('#candidate-gender').value
      ).to eq '1'
      expect(
        find('#birth_place').value
      ).to eq @candidate1.birth_place
      expect(
        find('#occupation').value
      ).to eq @candidate1.occupation
      expect(
        find('#education').value
      ).to eq @candidate1.education
      expect(
        find('#political_party').value
      ).to eq @candidate1.political_party
      expect(
        find('#candidate-experience').value
      ).to eq '1'

      # 登録内容を編集する
      fill_in 'last-name', with: '山田'
      fill_in 'first-name', with: '太郎'
      fill_in 'last-name-kana', with: 'ヤマダ'
      fill_in 'first-name-kana', with: 'タロウ'
      fill_in 'career', with: 'あいうえお'
      fill_in 'public-commitment', with: 'かきくけこ'
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Candidate.count }.by(0)
      # トップ画面に遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど変更した名前リンクが存在することを確認する
      expect(page).to have_content('山田' + ' ' + '太郎')
    end
  end
  context '立候補情報の編集ができないとき' do
    it 'ログインした有権者は自分以外の立候補情報編集画面には遷移できない' do
      # 立候補1の有権者でログインする
      visit new_electorate_session_path
      fill_in 'メールアドレス', with: @electorate1.email
      fill_in 'パスワード（6文字以上）', with: @electorate1.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      expect(page).to have_content(@candidate1.last_name)
      expect(page).to have_content(@candidate1.first_name)
      # 立候補2のページにに遷移し「編集」ボタンがないことを確認する
      visit candidate_path(@candidate2.id)
      expect(page).to have_no_link 'プロフィールを編集する', href: edit_candidate_path(@candidate2)
    end
    it 'ログインしていないと立候補情報の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 立候補1のページに遷移し「編集」ボタンがないことを確認する
      visit candidate_path(@candidate1.id)
      expect(page).to have_no_link 'プロフィールを編集する', href: edit_candidate_path(@candidate1)
      # 立候補2のページに遷移し「編集」ボタンがないことを確認する
      visit candidate_path(@candidate2.id)
      expect(page).to have_no_link 'プロフィールを編集する', href: edit_candidate_path(@candidate2)
    end
  end
end

RSpec.describe '立候補取り下げ', type: :system do
  before do
    @electorate1 = FactoryBot.create(:electorate)
    @electorate2 = FactoryBot.create(:electorate)
    @candidate1 = FactoryBot.create(:candidate, electorate_id: @electorate1.id)
    @candidate2 = FactoryBot.create(:candidate, electorate_id: @electorate2.id)
    @room1 = Room.create(candidate_id: @candidate1.id)
    @room2 = Room.create(candidate_id: @candidate2.id)
  end
  context '立候補取り下げができるとき' do
    it 'ログインした有権者は立候補を取り下げることができる' do
      # 立候補1の有権者でログインする
      visit new_electorate_session_path
      fill_in 'メールアドレス', with: @electorate1.email
      fill_in 'パスワード（6文字以上）', with: @electorate1.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 立候補1のページに「削除」ボタンがあることを確認する
      visit candidate_path(@candidate1.id)
      expect(page).to have_link '立候補を取りやめる', href: candidate_path(@candidate1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect do
        page.find_link('立候補を取りやめる', href: candidate_path(@candidate1)).click
      end.to change { Candidate.count }.by(-1)
      # 削除完了画面に遷移することを確認する
      expect(current_path).to eq root_path

      # トップページには立候補1の内容が存在しないことを確認する（画像）
      # expect(page).to have_no_selector ".content_post[style='background-image: url(#{@tweet1.image});']"
      # トップページには立候補1の内容が存在しないことを確認する（名前）
      expect(page).to have_no_content(@candidate1.last_name)
      expect(page).to have_no_content(@candidate1.first_name)
    end
  end
  context '立候補取り下げができないとき' do
    it 'ログインした有権者は自分以外の立候補を取り下げできない' do
      # 立候補1の有権者でログインする
      visit new_electorate_session_path
      fill_in 'メールアドレス', with: @electorate1.email
      fill_in 'パスワード（6文字以上）', with: @electorate1.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 立候補2に「立候補を取りやめる」ボタンが無いことを確認する
      visit candidate_path(@candidate2.id)
      expect(page).to have_no_link '削除', href: candidate_path(@candidate1)
    end
    it 'そもそもログインしていないと立候補取り下げボタンがない' do
      # 立候補1のページに「削除」ボタンが無いことを確認する
      visit candidate_path(@candidate1.id)
      expect(page).to have_no_link '削除', href: candidate_path(@candidate1)
    end
  end
end
