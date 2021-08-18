require 'rails_helper'

RSpec.describe 'Event', js: true, type: :system do
  let(:user) { create(:user) }

  describe 'イベントの表示' do
    let!(:events) { create_list(:event, 3) }
    subject { visit root_path }
    it 'イベント一覧を表示できる' do
      subject
      events.each do |event|
        expect(page).to have_css('.card-title', text: event.name)
      end
    end

    it 'イベント詳細を表示できる' do
      subject
      event = events.first
      click_on event.name
      expect(page).to have_css('.event-title', text: event.name)
      expect(page).to have_css('.card-text', text: event.text.to_plain_text)
    end
  end

  describe 'イベント投稿' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'イベントを投稿できる' do
        visit new_event_path
        event = FactoryBot.create(:event, name: 'name', text: 'text')
        fill_in 'イベント名', with: event.name
        fill_in_rich_text_area 'イベント詳細', with: event.text

        click_button '作成する'

        expect(page).to have_content name
        expect(page).to have_content text
      end

      it 'nameが未入力だとイベント投稿できず投稿ページにリダイレクトされる' do
        visit new_event_path
        event = FactoryBot.create(:event, name: 'name', text: 'text')
        fill_in 'イベント名', with: ''
        fill_in_rich_text_area 'イベント詳細', with: event.text
        click_button '作成する'

        expect(current_path).to eq new_event_path
      end
    end

    context 'ログインしてない場合' do
      it 'イベント投稿を押すとログイン画面に遷移する' do
        visit root_path
        click_on 'イベント作成'

        expect(current_path).to eq new_user_session_path
      end
    end
  end
end
