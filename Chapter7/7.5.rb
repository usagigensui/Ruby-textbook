# 7.5.1

# name=のようなセッターメソッドを呼び出す場合は、必ずselfをつける必要がある
class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename_to_bob
    # selfなしでname=メソッドを呼ぶ(?)
    name = 'Bob'
  end

  def rename_to_carol
    # selfつきでname=メソッドを呼ぶ
    self.name = 'Carol'
  end

  def rename_to_dave
    # 直接インスタンス変数を書き換える
    @name = 'Dave'
  end
end
user = User.new('Alice')

# Bobにリネームできていない
user.rename_to_bob
user.name #=> "Alice"

user.rename_to_carol
user.name #=> "Carol"

user.rename_to_dave
user.name #=> "Dave"

# 7.5.2

class Foo
  # 注：このpotsはクラス定義の読み込み時に呼び出される
  puts "クラス構文の直下のself: #{self}"

  def self.bar
    puts "クラスメソッド内のself: #{self}"
  end

  def baz
    puts "インスタンスメソッド内のself: #{self}"
  end
end
#=> クラス構文の直下のself: Foo

Foo.bar #=> クラスメソッド内のself: Foo

foo = Foo.new
foo.baz #=> インスタンスメソッド内のself: #<Foo:0x00000255d031aab0>
# これは「Fooクラスのインスタンス」を表している
# このため、クラスメソッドからインスタンスメソッドをselfで呼び出したり、
# インスタンスメソッドからクラスメソッドをselfで呼び出すとエラーする

# 7.5.3

class Product
  attr_reader : name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def self.format_price(price)
    "#{price}円"
  end

  def to_s
    # インスタンスメソッドからクラスメソッドを呼び出す
    formatted_price = Product.format_price(price)
    "name: #{name}, price: #{formatted_price}"
  end
end

product = Product.new('A great movie', 1000)
product.to_s #=> "name: A great movie, price: 1000円"