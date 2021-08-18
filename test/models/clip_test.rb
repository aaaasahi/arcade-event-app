# == Schema Information
#
# Table name: clips
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_clips_on_event_id  (event_id)
#  index_clips_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class ClipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
