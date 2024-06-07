Rails.application.routes.draw do
  root "top#index"
  get "about" => "top#about", as: "about"

  (1..18).each do |n|
    get "lesson/step#{n}(/:name)" => "lesson#step#{n}"
  end
end
