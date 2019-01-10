class TopController < ApplicationController

# second_layout.htmlを読み込む、Top画面にのみ、class=about wow fadeInUpの部分を適用するため
	#一覧ページ
	def index
	  @articles = Article.visible.order(released_at: :desc).limit(5)
      @articles = @articles.open_to_the_public unless current_member
      render :layout => "second_layout"
	end

	#会員になるにはページ
	def about
	end
end
