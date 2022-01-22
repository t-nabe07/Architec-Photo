class Public::CustomersController < ApplicationController
  #URLで直接他人のプロフィール編集不可
  before_action :ensure_current_customer, {only: [:edit, :update]}
  def ensure_current_customer
    if current_customer.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to("/")
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @productions = @customer.productions.page(params[:page]).reverse_order
    favorites = Favorite.where(customer_id: current_customer.id).pluck(:production_id)
    @favorite_list = Production.find(favorites)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id), notice: '編集が完了しました'
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました。またのご利用を心よりお待ちしております"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :introduction, :college_name, :specialty_study, :plofile_image)
  end

end
