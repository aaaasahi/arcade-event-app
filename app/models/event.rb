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

  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :text, presence: true

  #日付の表示
  def display_date
    if self.date.present?
      I18n.l(self.date, format: :default)
    end
  end

  #タグ作成
  def save_event_tag(tags)
    # 既にタグネームあるなら取得
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 共通要素取り出し
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # Destroy
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name:old_name)
    end
    # Create
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tag_name:new_name)
      self.tags << post_tag
    end
  end

  def eyecatch_image
    if eyecatch.attached?
      eyecatch
    else
      'http://placehold.jp/eeeeee/cccccc/200x150.png?text=No%20Image'
    end
  end
end
