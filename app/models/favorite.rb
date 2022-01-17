class Favorite < ApplicationRecord

  belongs_to :customer
  belongs_to :production

  #同じ投稿をお気に入りさせない
  validates_uniqueness_of :production_id, scope: :customer_id

end
