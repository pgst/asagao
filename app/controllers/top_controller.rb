class TopController < ApplicationController
  def index
    @message = 'おはようございます！'
    @description = 'これからRailsアプリケーションを作ります。'
  end

  def about
  end
end
