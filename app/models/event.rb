# == Schema Information
#
# Table name: events
#
#  id            :bigint           not null, primary key
#  date          :date
#  name          :string           not null
#  store         :string
#  text          :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :integer
#  prefecture_id :integer
#  user_id       :bigint           not null
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
class Event < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :category

  belongs_to :user
  has_one_attached :eyecatch

  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps

  validates :name, presence: true
  validates :text, presence: true

  def eyecatch_image
    if eyecatch.attached?
      eyecatch
    else
      'http://placehold.jp/eeeeee/cccccc/200x150.png?text=No%20Image'
    end
  end
end
