# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  tag_name   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_tag_name  (tag_name) UNIQUE
#
class Tag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy
  has_many :events, through: :tagmaps
end
