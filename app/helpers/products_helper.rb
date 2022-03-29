module ProductsHelper
  def my_reviews
    @product.reviews
  end

  def serial_number_generator
    password_items = '0123456789abcdefghijklmnopqrstuvwxyz'
    pass = ''
    index = 0

    while index < 10
      rand_value = rand 0..password_items.length - 1
      pass += password_items[rand_value]
      index += 1
    end

    pass
  end
end
