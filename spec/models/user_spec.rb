require 'rails_helper'

RSpec.describe User, type: :model do
  describe "正常系の機能" do
    context "正しく入力さている場合" do
      let(:user) { build(:user) }
      it "保存できる" do
        expect(user.valid?).to eq true
      end
    end
  end
  
  describe "バリデーション" do
    subject { user.valid? }
    context "email が空のとき" do
      let(:user) { build(:user, email: "") }
      it "保存できない" do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include "を入力してください"
      end
    end
    context "email が256文字以上のとき" do
      let(:user) { build(:user, email: "a" * 256) }
      it "保存できない" do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include "は255文字以内で入力してください"
      end
    end
    context "email がすでに存在するとき" do
      before { create(:user, email: "test@example.com") }
      let(:user) { build(:user, email: "test@example.com") }
      it "保存できない" do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include "はすでに存在します"
      end
    end
    context "email が アルファベット･英数字 のみのとき" do
      let(:user) { build(:user, email: Faker::Lorem.characters(number: 16)) }
      it "保存できない" do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include "は不正な値です"
      end
    end
  end
end
