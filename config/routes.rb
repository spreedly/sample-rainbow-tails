RainbowTailsSample::Application.routes.draw do
  get 'buy_tail' => 'tails#buy_tail'
  get 'transparent_redirect_complete' => 'tails#transparent_redirect_complete'
  get 'successful_purchase' => 'tails#successful_purchase'

  get 'about' => "home#about"
  root :to => "home#index"
end
