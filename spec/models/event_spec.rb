require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { event.valid? }
  let(:user) { build(:user) }
  describe "正常の機能" do
    context "全て正しく入力されているイベント投稿できる場合" do
      let(:event) { build(:event) }
      it "保存できる" do
        expect(subject).to eq true
      end
      it "store が未入力でも保存できる" do 
        build(:event, store: "") 
        expect(subject).to eq true
      end
      it "address が未入力でも保存できる" do 
        build(:event, address: "") 
        expect(subject).to eq true
      end
      it "start_time が未入力でも保存できる" do 
        build(:event, start_time: "") 
        expect(subject).to eq true
      end
      it "category_id が未入力でも保存できる" do 
        build(:event, category_id: nil) 
        expect(subject).to eq true
      end
    end
  end

  describe "バリデーション" do
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
    context "store が50文字以上の場合" do
      let(:event) { build(:event, store: Faker::Lorem.characters(number: 51) ) }
      it "保存できない" do
        expect(subject).to eq false
        expect(event.errors.messages[:store]).to include "は50文字以内で入力してください"
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

  describe "削除時の関連性" do
    context "event が削除された場合" do
      subject { event.destroy }
      let(:event) { create(:event) }
      it "join も削除される" do
        create_list(:join, 2, event: event)
        create(:join)
        expect { subject }.to change { event.joins.count }.by(-2)
      end
      it "clip も削除される" do
        create_list(:clip, 2, event: event)
        create(:clip)
        expect { subject }.to change { event.clips.count }.by(-2)
      end
      it "comment も削除される" do
        create_list(:comment, 2, event: event)
        create(:comment)
        expect { subject }.to change { event.comments.count }.by(-2)
      end
    end
  end

  describe "アソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    let(:event) { create(:event) }

    context "Userモデルとのアソシエーション" do
      let(:target) { :user }
      it "Userとの関連付けはbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "Joinモデルとのアソシエーション" do
      let(:target) { :joins }
      it "Joinとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end

    context "Clipモデルとのアソシエーション" do
      let(:target) { :clips }
      it "Clipとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end

    context "Commentモデルとのアソシエーション" do
      let(:target) { :comments }
      it "Commentとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end
  end

end
