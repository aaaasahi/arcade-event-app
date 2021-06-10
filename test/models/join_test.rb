# == Schema Information
#
# Table name: joins
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_joins_on_event_id  (event_id)
#  index_joins_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class JoinTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
