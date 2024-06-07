Rails.application.config.generators do |g|
  # ヘルパーを生成しない
  g.helper false

  # CSS, JavaScriptファイルを生成しない
  g.assets false

  # config/routesファイルを変更しない
  g.skip_routes true

  # テストスクリプトを生成しない
  g.test_framework false
end
