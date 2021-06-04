# == Schema Information
#
# Table name: tagmaps
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  tag_id     :bigint           not null
#
# Indexes
#
#  index_tagmaps_on_event_id  (event_id)
#  index_tagmaps_on_tag_id    (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (tag_id => tags.id)
#
require "test_helper"

class TagmapTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
