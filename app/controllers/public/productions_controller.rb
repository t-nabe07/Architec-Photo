class Public::ProductionsController < ApplicationController
  before_action :authenticate_customer!, except: [:index]

  def new
    @production = Production.new
  end

  def create
    @production = Production.new(production_params)
    @production.customer_id = current_customer.id
    if @production.save
      redirect_to production_path(@production.id), notice: '投稿が完了しました'
    else
      render :new
    end
  end

  def index
    @production = Production.page(params[:page]).reverse_order
    # いいね数の比較メソッド
    @productions = Production.find(Good.group(:production_id).
                             order('count(production_id) desc').
                             limit(4).
                             pluck(:production_id))
  end

  def show
    @production = Production.find(params[:id])
    @comment = Comment.new
    #shoeアクセスでPV数１つ増える。 ip_address管理。
    impressionist(@production, nil, unique: [:ip_address])
  end

  def edit
    @production = Production.find(params[:id])
  end

  def update # 複数画像の場合選択削除
    @production = Production.find(params[:id])
    if params[:production][:image_ids]
      params[:production][:image_ids].each do |image_id|
        image = @production.images.find(image_id)
        image.purge
      end
    end
    if @production.update_attributes(production_params)
      redirect_to production_path(@production.id), notice: "更新が完了しました"
    else
      render :edit
    end
  end

  def destroy
    @production = Production.find(params[:id])
    @production.destroy
    redirect_to productions_path
  end

  private

  def production_params
    params.require(:production).permit(:title, :introduction, images: [])
  end
end
