class ArticlesController < ApplicationController
  before_action :login_required, except: [:index, :show]

  # 記事一覧
  def index
    @articles = Article.order(released_at: :desc)
    @articles = @articles.open_to_the_public unless current_member
    @articles = @articles.visible unless current_member&.administrator?
    @articles = @articles.page(params[:page]).per(5)
  end

  # 記事詳細
  def show
    articles = Article.all
    articles = articles.open_to_the_public unless current_member
    articles = articles.visible unless current_member&.administrator?
    @article = articles.find(params[:id])
  end

  # 新規登録フォーム
  def new
    @article = Article.new
  end

  # 編集フォーム
  def edit
    @article = Article.find(params[:id])
  end

  # 新規作成
  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to @article, notice: '記事を作成しました。'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  # 更新
  def update
    @article = Article.find(params[:id])
    @article.assign_attributes(params[:article])
    if @article.save
      redirect_to @article, notice: '記事を更新しました。'
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  # 削除
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to :articles, notice: '記事を削除しました。', status: :see_other
  end
end
