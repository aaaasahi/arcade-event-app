require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { build(:user) }
  describe "正常系の機能" do
    context "正しく入力さている場合" do
      let(:event) { build(:event) }
      it "保存できる" do
        expect(event.valid?).to eq true
      end
    end
  end

  describe "バリデーション" do
    subject { event.valid? }
    context "name が空の場合" do
      let(:event) { build(:event, name: "") }
      it "保存できない" do
        expect(subject).to eq false
        expect(event.errors.messages[:name]).to include "を入力してください"
      end
    end
    context "name が2文字以下の場合" do
      let(:event) { build(:event, name: Faker::Lorem.characters(number: 1) ) }
      it "保存できない" do
        expect(subject).to eq false
        expect(event.errors.messages[:name]).to include "は2文字以上で入力してください"
      end
    end
    context "name が50文字以上の場合" do
      let(:event) { build(:event, name: Faker::Lorem.characters(number: 51) ) }
      it "保存できない" do
        expect(subject).to eq false
        expect(event.errors.messages[:name]).to include "は50文字以内で入力してください"
      end
    end
    context "text が空の場合" do
      let(:event) { build(:event, text: "") }
      it "保存できない" do
        expect(subject).to eq false
        expect(event.errors.messages[:text]).to include "を入力してください"
      end
    end
    context "store が2文字以下の場合" do
      let(:event) { build(:event, store: Faker::Lorem.characters(number: 1) ) }
      it "保存できない" do
        expect(subject).to eq false
        expect(event.errors.messages[:store]).to include "は2文字以上で入力してください"
      end
    end
    context "store が50文字以上の場合" do
      let(:event) { build(:event, store: Faker::Lorem.characters(number: 51) ) }
      it "保存できない" do
        expect(subject).to eq false
        expect(event.errors.messages[:store]).to include "は50文字以内で入力してください"
      end
    end
    context "address が2文字以下の場合" do
      let(:event) { build(:event, address: Faker::Lorem.characters(number: 1) ) }
      it "保存できない" do
        expect(subject).to eq false
        expect(event.errors.messages[:address]).to include "は2文字以上で入力してください"
      end
    end
    context "address が50文字以上の場合" do
      let(:event) { build(:event, address: Faker::Lorem.characters(number: 51) ) }
      it "保存できない" do
        expect(subject).to eq false
        expect(event.errors.messages[:address]).to include "は50文字以内で入力してください"
      end
    end
    context "start_time が今日より前の日付の場合" do
      let(:event) { build(:event, start_time: "2000-07-30" ) }
      it "保存できない" do
        expect(subject).to eq false
        expect(event.errors.messages[:base]).to include "開催日程は今日より前の日は指定できません"
      end
    end
  end
end
