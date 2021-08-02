require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { comment.valid? }
  let(:user) { build(:user) }
  let(:event) { build(:event) }

  describe "正常の機能" do
    context "正しく入力さている場合" do
      let(:comment) { build(:comment) }
      it "保存できる" do
        expect(subject).to eq true
      end
    end
  end

  describe "バリデーション" do
    context "content が空の場合" do
      let(:comment) { build(:comment, content: "") }
      it "保存できない" do
        expect(subject).to eq false
        expect(comment.errors.messages[:content]).to include "を入力してください"
      end
    end
    context "content が300文字以上の場合" do
      let(:comment) { build(:comment, content: Faker::Lorem.characters(number: 301) ) }
      it "保存できない" do
        expect(subject).to eq false
        expect(comment.errors.messages[:content]).to include "は300文字以内で入力してください"
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "Userモデルとのアソシエーション" do
      let(:target) { :user }

      it "Userとの関連付けはbelongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end

    context "Eventモデルとのアソシエーション" do
      let(:target) { :event }

      it "Eventとの関連付けはbelongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end
  end

end
