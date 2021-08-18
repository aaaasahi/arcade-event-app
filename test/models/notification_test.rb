# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  action     :string           default(""), not null
#  checked    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer
#  message_id :integer
#  room_id    :integer
#  visited_id :integer          not null
#  visitor_id :integer          not null
#
# Indexes
#
#  index_notifications_on_event_id    (event_id)
#  index_notifications_on_message_id  (message_id)
#  index_notifications_on_room_id     (room_id)
#  index_notifications_on_visited_id  (visited_id)
#  index_notifications_on_visitor_id  (visitor_id)
#
require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
