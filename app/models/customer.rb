class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :productions,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :goods,dependent: :destroy
  #Active Storage用
  has_one_attached :plofile_image

  validates :last_name,presence:true
  validates :first_name,presence:true
  validates :last_name_kana,presence:true, format: { with: /\A[ｧ-ﾝﾞﾟ]+\z/, message: 'は半角カタカナで入力してください。' }
  validates :first_name_kana,presence:true, format: { with: /\A[ｧ-ﾝﾞﾟ]+\z/, message: 'は半角カタカナで入力してください。' }
  validates :college_name,presence:true

  #フルネーム(nilの場合を除く）)
  def full_name
    self.last_name + " " + self.first_name
  end

  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end

  #enum
  enum is_deleted: {withdraw: true, active: false}

end
