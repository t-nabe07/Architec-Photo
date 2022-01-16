class Production < ApplicationRecord

  belongs_to :customer
  has_many :comments,dependent: :destroy
  #Active Storage用
  has_many_attached :images

  #フルネーム(nilの場合を除く）
  def full_name
    self.last_name + " " + self.first_name
  end

  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end

end
