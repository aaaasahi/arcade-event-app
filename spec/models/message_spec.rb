require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { message.valid? }
  describe "正常の機能" do
    context "正しく入力さている場合" do
      let(:message) { build(:message) }
      it "送信できる" do
        expect(subject).to eq true
      end
    end
  end
  describe "バリデーション" do
    context "body が空の場合" do
      let(:message) { build(:message, body: "") }
      it "送信できない" do
        expect(subject).to eq false
        expect(message.errors.messages[:body]).to include "を入力してください"
      end
    end
    context "body が300文字以上の場合" do
      let(:message) { build(:message, body: Faker::Lorem.characters(number: 301) ) }
      it "送信できない" do
        expect(subject).to eq false
        expect(message.errors.messages[:body]).to include "は300文字以内で入力してください"
      end
    end
  end
end
