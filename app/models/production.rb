class Production < ApplicationRecord
  before_commit :authenticate_customer!

  belongs_to :customer, optional: true
  has_many :comments,dependent: :destroy
  has_many :goods,dependent: :destroy
  has_many :favorites,dependent: :destroy
  #Active Storage用
  has_many_attached :images

  #フルネーム(nilの場合を除く）
  def full_name
    self.last_name + " " + self.first_name
  end

  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end


  def gooded_by?(customer)
    goods.where(customer_id: customer.id).exists?
  end

end
