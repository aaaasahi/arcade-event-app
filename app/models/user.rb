# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
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
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :clips, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :clip_events, through: :clips, source: :event
  has_many :join_events, through: :joins, source: :event

  has_one :profile, dependent: :destroy

  delegate :gender, :introduction, :age_cal, to: :profile, allow_nil: true

  #パスワードなしで変更可能
  def update_without_current_password(params, *options)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
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

  def active_for_authentication?
    super && (is_valid == true)
  end
end
