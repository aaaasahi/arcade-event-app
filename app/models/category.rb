class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: I18n.t('events.search.music') }, { id: 2, name: I18n.t('events.search.video') }, { id: 3, name: I18n.t('events.search.card') },
    { id: 4, name: I18n.t('events.search.other') }
  ]

  include ActiveHash::Associations
  has_many :events
end
