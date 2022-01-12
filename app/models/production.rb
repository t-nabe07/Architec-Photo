class Production < ApplicationRecord

  belongs_to :customer

  #Active Storage用
  has_one_attached :image
  has_many_attached :images

end
