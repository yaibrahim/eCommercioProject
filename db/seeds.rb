product_owner = User.create(
  email: 'i123@gmail.com',
  full_name: 'M Haris',
  password: 'pakistan123'
)

10.times do
  Product.create(
    name: FFaker::Product.product_name,
    price: rand(1..32000),
    description: FFaker::Tweet.body,
    user_id: product_owner.id
  )
end

product = Product.create(
  name: FFaker::Product.product_name,
  price: rand(1..32000),
  description: FFaker::Tweet.body,
  user_id: product_owner.id
)
product.save

customer = User.create(
  email: 'yasheikh@gmail.com',
  full_name: 'M Sheikh',
  password: 'pakistan123'
)

Review.create(user_id: customer.id, product_id: product.id, review_message: 'Best One :)')

Review.create(user_id: customer.id, product_id: product.id, review_message: 'Awesome :D')

order = Order.create(user_id: customer.id)

OrderItem.create(order_id: order.id, product_id: product.id)
