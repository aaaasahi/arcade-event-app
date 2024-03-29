# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  administrator          :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  is_valid               :boolean          default(TRUE), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :clips, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :clip_events, through: :clips, source: :event
  has_many :join_events, through: :joins, source: :event
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  has_one :profile, dependent: :destroy

  delegate :gender, :introduction, :age_cal, to: :profile, allow_nil: true

  # パスワードなしで変更可能
  def update_without_current_password(params, *options)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end

  # ゲストユーザー
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def has_clipped?(event)
    clips.exists?(event_id: event.id)
  end

  def has_joined?(event)
    joins.exists?(event_id: event.id)
  end

  def prepare_profile
    profile || build_profile
  end

  # 退会処理
  def active_for_authentication?
    super && (is_valid == true)
  end
end
