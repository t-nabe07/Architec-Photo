class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name,presence:true
  validates :first_name,presence:true
  validates :last_name_kana,presence:true, format: { with: /\A[ｧ-ﾝﾞﾟ]+\z/, message: 'は半角カタカナで入力してください。' }
  validates :first_name_kana,presence:true, format: { with: /\A[ｧ-ﾝﾞﾟ]+\z/, message: 'は半角カタカナで入力してください。' }
  validates :college_name,presence:true

  has_many :productions,dependent: :destroy

  #フルネーム(nilの場合を除く）)
  def full_name
    self.last_name + " " + self.first_name
  end

  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end

end
