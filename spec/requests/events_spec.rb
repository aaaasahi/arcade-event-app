require 'rails_helper'

RSpec.describe 'Events', type: :request do
  let(:user) { create(:user) }
  before do
    sign_in user
  end

  describe 'GET #index' do
    subject { get(events_path) }

    context 'イベントが存在する場合' do
      let!(:event) { create(:event, user_id: user.id) }

      it 'リクエストが成功する' do
        subject
        expect(response).to have_http_status(200)
      end

      it 'name が表示されている' do
        subject
        expect(response.body).to include event.name
      end
    end
  end

  describe 'GET #show' do
    subject { get(event_path(event.id)) }

    context 'イベントが存在する場合' do
      let(:event) { create(:event, user_id: user.id) }

      it 'リクエストが成功する' do
        subject
        expect(response).to have_http_status(200)
      end

      it 'name が表示されている' do
        subject
        expect(response.body).to include event.name
      end
    end
  end

  describe 'GET #new' do
    subject { get(new_event_path) }

    it 'リクエストが成功する' do
      subject
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    subject { post(events_path, params: params) }

    context 'パラメータが正常な場合' do
      let(:params) { { event: attributes_for(:event) } }

      it '投稿が保存される' do
        expect { subject }.to change { Event.count }.by(1)
      end

      it 'リクエストが成功する' do
        subject
        expect(response).to have_http_status(302)
      end

      it 'イベント一覧ページにリダイレクトされる' do
        subject
        expect(response).to redirect_to('http://www.example.com/events?locale=ja')
      end
    end

    context 'パラメータが異常な場合' do
      let(:params) { { event: attributes_for(:event, :invalid) } }

      it 'リクエストが成功する' do
        subject
        expect(response).to have_http_status(200)
      end

      it '投稿が保存されない' do
        expect { subject }.not_to change(Event, :count)
      end

      it 'イベント投稿ページがレンダリングされる' do
        subject
        expect(response.body).to include I18n.t('events.form.event-post')
      end
    end
  end

  describe 'GET #edit' do
    subject { get(edit_event_path(event_id)) }

    context 'イベントが存在する場合' do
      let(:event) { create(:event, user_id: user.id) }
      let(:event_id) { event.id }

      it 'リクエストが成功する' do
        subject
        expect(response).to have_http_status(200)
      end

      it 'name が表示されている' do
        subject
        expect(response.body).to include event.name
      end
    end
  end

  describe 'PATCH #update' do
    subject { patch(event_path(event.id), params: params) }
    let(:event) { create(:event, user_id: user.id) }

    context 'パラメーターが正常な場合' do
      let(:params) { { event: attributes_for(:event) } }

      it 'リクエストが成功する' do
        subject
        expect(response).to have_http_status(302)
      end

      it 'name が更新される' do
        origin_name = event.name
        new_name = params[:event][:name]
        expect { subject }.to change { event.reload.name }.from(origin_name).to(new_name)
      end
    end

    context 'パラメータが異常なとき' do
      let(:params) { { event: attributes_for(:event, :invalid) } }

      it 'リクエストが成功する' do
        subject
        expect(response).to have_http_status(200)
      end

      it 'name が更新されない' do
        expect { subject }.not_to change(event.reload, :name)
      end

      it 'イベント編集ページがレンダリングされる' do
        subject
        expect(response.body).to include I18n.t('events.form.event-edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete(event_path(event.id)) }
    let!(:event) { create(:event, user_id: user.id) }

    context 'パラメータが正常な場合' do
      it 'リクエストが成功する' do
        subject
        expect(response).to have_http_status(302)
      end

      it 'イベントが削除される' do
        expect { subject }.to change(Event, :count).by(-1)
      end

      it 'イベント一覧にリダイレクトすること' do
        subject
        expect(response).to redirect_to('http://www.example.com/events?locale=ja')
      end
    end
  end
end
