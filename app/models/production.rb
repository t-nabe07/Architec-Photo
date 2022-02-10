class Production < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # Active Storage複数投稿用
  has_many_attached :images
  # 通知機能
  has_many :notifications, dependent: :destroy

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

  # 通知機能　いいねとコメントのメソッド
  def create_notification_good!(current_customer)
    #既にいいねされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and production_id = ? and action = ? ", current_customer.id, customer_id, id, 'good'])
    #いいねされていない場合のみ、通知レコード作成
    if temp.blank?
      notification = current_customer.active_notifications.new(
        production_id: id,
        visited_id: customer_id,
        action: "good"
      )
      #自分の投稿に対するいいねの場合は通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_customer, comment_id)
    #自分以外にコメントしている人を全て取得し、全員に通知を送る
    temp_ids = Comment.select(:customer_id).where(production_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_customer, comment_id, temp_id['customer_id'])
    end
    #まだ誰もコメントしてない場合は投稿者に通知を送る
    save_notification_comment!(current_customer, comment_id, customer_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_customer, comment_id, visited_id)
    #コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_customer.active_notifications.new(
      production_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    #自分の投稿に対するコメントの場合は通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  #検索機能の条件分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @production = Production.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @production = Production.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @production = Production.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @production = Production.where("title LIKE?", "%#{word}%")
    else
      @production = Production.all
    end
  end

end
