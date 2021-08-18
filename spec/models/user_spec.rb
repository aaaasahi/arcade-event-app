require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user.valid? }
  describe '正常の機能' do
    context '正しく入力さている場合' do
      let(:user) { build(:user) }
      it '保存できる' do
        expect(subject).to eq true
      end
    end
  end

  describe 'バリデーション' do
    context 'email が空の場合' do
      let(:user) { build(:user, email: '') }
      it '保存できない' do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include 'を入力してください'
      end
    end
    context 'email が256文字以上の場合' do
      let(:user) { build(:user, email: Faker::Lorem.characters(number: 257)) }
      it '保存できない' do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include 'は255文字以内で入力してください'
      end
    end
    context 'email がすでに存在する場合' do
      before { create(:user, email: 'test@example.com') }
      let(:user) { build(:user, email: 'test@example.com') }
      it '保存できない' do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include 'はすでに存在します'
      end
    end
    context 'email が アルファベット･英数字 のみの場合' do
      let(:user) { build(:user, email: Faker::Lorem.characters(number: 15)) }
      it '保存できない' do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include 'は不正な値です'
      end
    end
    context 'password が空の場合' do
      let(:user) { build(:user, password: '') }
      it '保存できない' do
        expect(subject).to eq false
        expect(user.errors.messages[:password]).to include 'を入力してください'
      end
    end
    context 'パスワードが5文字以下のとき' do
      let(:user) { build(:user, password: Faker::Lorem.characters(number: 5)) }
      it '保存できない' do
        expect(subject).to eq false
        expect(user.errors.messages[:password]).to include 'は6文字以上で入力してください'
      end
    end
  end

  describe '削除時の関連性' do
    context 'user が削除された場合' do
      subject { user.destroy }
      let(:user) { create(:user) }
      it 'event も削除される' do
        create_list(:event, 2, user: user)
        create(:event)
        expect { subject }.to change { user.events.count }.by(-2)
      end
      it 'join も削除される' do
        create_list(:join, 2, user: user)
        create(:join)
        expect { subject }.to change { user.joins.count }.by(-2)
      end
      it 'clip も削除される' do
        create_list(:clip, 2, user: user)
        create(:clip)
        expect { subject }.to change { user.clips.count }.by(-2)
      end
      it 'comment も削除される' do
        create_list(:comment, 2, user: user)
        create(:comment)
        expect { subject }.to change { user.comments.count }.by(-2)
      end
      it 'message も削除される' do
        create_list(:message, 2, user: user)
        create(:message)
        expect { subject }.to change { user.messages.count }.by(-2)
      end
    end
  end

  describe 'アソシエーション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    let(:user) { create(:user) }

    context 'Eventモデルとのアソシエーション' do
      let(:target) { :events }
      it 'Eventとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'Joinモデルとのアソシエーション' do
      let(:target) { :joins }
      it 'Joinとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'Clipモデルとのアソシエーション' do
      let(:target) { :clips }
      it 'Clipとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'Commentモデルとのアソシエーション' do
      let(:target) { :comments }
      it 'Commentとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
