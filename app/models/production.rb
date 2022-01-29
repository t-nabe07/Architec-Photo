class Production < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # Active Storage複数投稿用
  has_many_attached :images

  validates :title, presence: true
  validates :introduction, presence: true
  validates :images, presence: true, 
                     file_size: { maximum: 2.megabytes },
                     file_number: { maximum: 3 }

  # フルネーム(nilの場合を除く）
  def full_name
    last_name + " " + first_name
  end

  def full_name_kana
    last_name_kana + " " + first_name_kana
  end

  # いいね表示のための定義
  def gooded_by?(customer)
    goods.where(customer_id: customer.id).exists?
  end
end
