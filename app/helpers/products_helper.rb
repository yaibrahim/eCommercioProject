module ProductsHelper
  def my_reviews
    @product.reviews
  end

  # this is wrong usage of helper. Helpers are meant to provide helper methods to views or controllers. NOT TO MODELS.
  def serial_number_generator
    # password_items variable in serial_number_generator doesnt make sense :(

    # Also the serial number could be "#{self.id}_#{self.created_at}_#{self.user_id}" this could have made serial number proper and methodological
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
