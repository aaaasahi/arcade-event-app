# == Schema Information
#
# Table name: events
#
#  id            :bigint           not null, primary key
#  address       :string
#  latitude      :float
#  longitude     :float
#  name          :string           not null
#  start_time    :date
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
require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
