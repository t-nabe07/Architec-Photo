class Public::NotificationsController < ApplicationController
  before_action :authenticate_customer!

  def index
    #current_customerの投稿に紐づいた通知一覧
    @notifications = current_customer.passive_notifications
    #notificationの中でまだ確認していない通知
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def all_destroy
    @notifications = current_customer.passive_notifications.destroy_all
    redirect_to notifications_path
  end

end
