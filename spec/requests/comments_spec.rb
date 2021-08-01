require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  before do
    sign_in user
  end

  describe "POST #create" do
    let(:new_event) { create(:event, user_id: user.id) }
    let(:event_id) { new_event.id }
    subject { post(event_comments_path(event_id), params: params) }

    context "正常な場合" do
      let(:params) { { comment: attributes_for(:comment) } }

      it "コメントできる" do
        expect { subject }.to change { Comment.count }.by(1)
      end

    end
  end
end
