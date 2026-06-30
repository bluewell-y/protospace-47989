class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  before_action :move_to_index, only: :edit

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
      @commnent = Comment.new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    #データを更新できたかどうかで条件分岐
    if @prototype.update(prototype_params)
      #更新できたら、プロトタイプの詳細画面へリダイレクト
      redirect_to prototype_path(@prototype)
    else
      #バリデーンエラーなどで更新できなかったら、編集画面を再表示
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])

    #データベースから削除
    prototype.destroy

    #トップページへリダイレクト
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    @prototype = Prototype.find(params[:id])
    # ログインしているユーザーのIDと、プロトタイプの投稿者のIDが一致しない場合
    unless current_user.id == @prototype.user_id
      redirect_to root_path
    end
  end
end
