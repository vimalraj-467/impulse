class FlashSaleController < ImpulseController
  get "/:sale_id" do |sale_id|
    sale_id
  end

  get '/' do
    "Hello, World! from Flash Sale"
  end
end
