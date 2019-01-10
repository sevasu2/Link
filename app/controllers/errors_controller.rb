class ErrorsController < ActionController::Base
  layout "error"

  #エラー画面表示の設定
  def show
    case request.env["action_dispatch.exception"] #action_dispatch.exceptionで発生した例外で取得する
    when ActionController::RoutingError
      render "not_found", status: 404, formats: [:html] #404エラー画面へ
    else
      render "internal_server_error", status: 500, formats: [:html] #500エラー画面へ
    end
  end
end
