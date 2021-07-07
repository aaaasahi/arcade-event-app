# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  address     :string
#  latitude    :float
#  longitude   :float
#  name        :string           not null
#  start_time  :date
#  status      :boolean          default(FALSE)
#  store       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  user_id     :bigint           not null
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
class Event < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  geocoded_by :address
  after_validation :geocode
  
  belongs_to_active_hash :category

  belongs_to :user
  has_one_attached :eyecatch

  has_rich_text :text

  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps
  has_many :comments, dependent: :destroy
  has_many :clips, dependent: :destroy
  has_many :joins, dependent: :destroy

  validates :name, presence: true
  validates :text, presence: true
  validate :day_after_today

  def day_after_today
    if start_time.present? && start_time < Date.today
      errors.add(:base, "開催日程は今日より前の日は指定できません") 
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

  #ソート
  scope :latest, -> {order(updated_at: :desc)}
  scope :old, -> {order(updated_at: :asc)}
  scope :join_count, -> { includes(:joins).sort {|a,b| b.joins.size <=> a.joins.size}}
  
  #検索
  scope :key_search, -> (search_param = nil) {
    return if search_param.blank?
    joins("INNER JOIN action_text_rich_texts ON action_text_rich_texts.record_id = events.id AND action_text_rich_texts.record_type = 'Event'")
    .where("action_text_rich_texts.body LIKE ? OR events.name LIKE ? ", "%#{search_param}%", "%#{search_param}%")
  }

  scope :store_search, -> (search_param = nil) {
    return if search_param.blank?
    where("events.store LIKE ? OR events.address LIKE ? ", "%#{search_param}%", "%#{search_param}%")
  }


end
