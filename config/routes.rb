RainbowTailsSample::Application.routes.draw do

  match 'buy_tail' => 'tails#buy_tail'
  match 'transparent_redirect_complete' => 'tails#transparent_redirect_complete'
  match 'successful_purchase' => 'tails#successful_purchase'

  get 'about' => "home#about"
  root :to => "home#index"

end
