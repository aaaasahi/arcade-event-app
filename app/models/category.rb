class Category < ActiveHash::Base

  self.data = [
    {id: 1, name: '音楽ゲーム'}, {id: 2, name: 'ビデオゲーム'}, {id: 3, name: 'カードゲーム'},
    {id: 4, name: 'その他'}
  ]

  include ActiveHash::Associations
  has_many :events

end