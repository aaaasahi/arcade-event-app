require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { profile.valid? }
  let(:user) { build(:user) }
  describe "正常の機能" do
    context "正しく入力さている場合" do
      let(:profile) { build(:profile) }
      it "保存できる" do
        expect(subject).to eq true
      end
    end
  end

  describe "バリデーション" do 
    context "name が空の場合" do 
      let(:profile) { build(:profile, name: "") }
      it "保存できない" do
        expect(subject).to eq false
        expect(profile.errors.messages[:name]).to include "を入力してください"
      end
    end
    context "name が50文字以上の場合" do
      let(:profile) { build(:profile, name: Faker::Lorem.characters(number: 51) ) }
      it "保存できない" do
        expect(subject).to eq false
        expect(profile.errors.messages[:name]).to include "は50文字以内で入力してください"
      end
    end
    context "introduction が300文字以上の場合" do
      let(:profile) { build(:profile, introduction: Faker::Lorem.characters(number: 301) ) }
      it "保存できない" do
        expect(subject).to eq false
        expect(profile.errors.messages[:introduction]).to include "は300文字以内で入力してください"
      end
    end
  end
end
