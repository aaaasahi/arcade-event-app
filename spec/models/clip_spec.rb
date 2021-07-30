require 'rails_helper'

RSpec.describe Clip, type: :model do
  subject { clip.valid? }
  describe "正常の機能" do
    context "データが条件を満たす場合" do
      let(:clip) { build(:clip) }
      it "保存できる" do
        expect(subject).to eq true
      end
    end
  end

  describe "バリデーション" do
    context "user_idが存在しない場合" do
      let(:clip) { build(:join, user_id: nil) }
      it "保存できない" do
        expect(subject).to eq false
        expect(clip.errors.messages[:user]).to include "を入力してください"
      end
    end
    context "event_idが存在しない場合" do
      let(:clip) { build(:join, event_id: nil) }
      it "保存できない" do
        expect(subject).to eq false
        expect(clip.errors.messages[:event]).to include "を入力してください"
      end
    end
    context "user_idが既に存在する場合" do
      let(:user) { create(:user) }
      let(:event) { create(:event, user_id: user.id) }
      before do
        create(:clip, user_id: user.id, event_id: event.id)
      end
      let(:clip) { build(:clip, user_id: user.id, event_id: event.id) }
      
      it "保存できない" do
        expect(subject).to eq false
        expect(clip.errors.messages[:user_id]).to include "はすでに存在します"
      end
    end
  end
end
