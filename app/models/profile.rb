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

  #年齢計算
  def age_cal
    return '不明' unless age.present?
    years = Time.zone.now.year - age.year
    days = Time.zone.now.yday - age.yday
    if days < 0
      "#{years - 1}歳"
    else
      "#{years}歳"
    end
  end
end
