# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  age          :date
#  gender       :integer
#  introduction :text
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
  enum gender: { male: 0, female: 1, other: 2 }
  belongs_to :user
  has_one_attached :avatar

  validates :name, presence: true, length: { maximum: 50 }
  validates :introduction, length: { maximum: 300 }
  validate :birthday_cannot_be_in_the_future

  def birthday_cannot_be_in_the_future
    if age.present? && age > Date.today
      errors.add(:base, '0歳以下の年齢を設定することはできません。')
    end
  end


end
