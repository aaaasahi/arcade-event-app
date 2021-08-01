require 'rails_helper'

RSpec.describe "Joins", type: :request do
  let(:user) { create(:user) }
  before do
    sign_in user
  end

  describe "POST #create" do
    let(:new_event) { create(:event, user_id: user.id) }
    let(:event_id) { new_event.id }
    subject { post(event_join_path(event_id), xhr: true) }

    context "正常な場合" do
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(200)
      end

      it "joinできる" do 
        expect { subject }.to change { Join.count }.by(1)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:event) { create(:event, user_id: user.id) }
    before do
      create(:join, user_id: user.id, event_id: event.id)
    end
    subject { delete(event_join_path(event.id), xhr: true) }

    context "正常な場合" do
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(200)
      end

      it 'いいねが削除される' do
        expect { subject }.to change(Join, :count).by(-1)
      end
    end
  end
end
