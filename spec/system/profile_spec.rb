require 'rails_helper'

RSpec.describe 'Profile', type: :system do
  let!(:user) { create(:user) }
  let!(:profile) { create(:profile) }

  context 'ログインしている場合' do
    before do
      sign_in user
    end

    it '自分のプロフィールを確認できる' do
      visit profile_path
      expect(page).to have_css('.profile-name', text: user.display_name)
    end

    it "プロフィールの編集ができる" do 
      visit edit_profile_path
      profile = FactoryBot.create(:profile, name: "プロフィールテスト")
      fill_in "ユーザー名", with: profile.name
      click_button I18n.t('profiles.btn')
  
      expect(page).to have_content("プロフィールテスト")
    end

    it "nameが未入力だとプロフィール編集ができずリダイレクトされる" do 
      visit edit_profile_path
      profile = FactoryBot.create(:profile, name: "プロフィールテスト")
      fill_in  "ユーザー名", with: ""
      click_button I18n.t('profiles.btn')

      expect(current_path).to eq profile_path

    end
  end

  context "ログインしていない場合" do 
    it "プロフィールページのボタンが表示されない" do 
      visit root_path 
      expect(page).to have_no_css('.nav-link', text: "マイページ")
    end
  end

  
end