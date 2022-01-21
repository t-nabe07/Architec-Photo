class Production < ApplicationRecord

  belongs_to :customer, optional: true
  has_many :comments,dependent: :destroy
  has_many :goods,dependent: :destroy
  has_many :favorites,dependent: :destroy
  #Active Storage複数投稿用
  has_many_attached :images

  validates :title, presence: true
  validates :introduction, presence: true
  validates :images, presence: true

  def images_presence
    if images.attached?
      if !images.content_type.in?(%('image/jpeg image/png'))
        errors.add(:images, 'にはjpegまたはpngファイルを添付してください')
      end
    else
      errors.add(:images, 'ファイルを添付してください')
    end
  end

  #フルネーム(nilの場合を除く）
  def full_name
    self.last_name + " " + self.first_name
  end

  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end

  #いいね表示のための定義
  def gooded_by?(customer)
    goods.where(customer_id: customer.id).exists?
  end

end
