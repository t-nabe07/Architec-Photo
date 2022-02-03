class Comment < ApplicationRecord

  belongs_to :customer
  belongs_to :production
  has_many :notifications, dependent: :destroy
  
end
