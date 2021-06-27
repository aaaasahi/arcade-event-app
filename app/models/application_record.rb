class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  scope :week, -> { where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :yesterday, -> { where(created_at: 1.day.ago.all_day) }
end
