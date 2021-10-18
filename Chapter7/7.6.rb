# 7.6.2

# 独自に作成したクラスはデフォルトでObjectクラスを継承している
class User
end

user = User.new
user.nil? #=> false

User.superclass #=> Object

# 7.6.3

user = User.new
user.class #=> User

# instance_of?メソッドでオブジェクトのクラスを調べることができる
user.instance_of?(User) #=> true
user.instance_of?(String) #=> false

# is-a?メソッドで継承関係(is-a関係)になるかどうか確認できる
user.is_a?(User)        #=> true
user.is_a?(Object)      #=> true
user.is_a?(BasicObject) #=> true
user.is_a?(String)      #=> false

# 7.6.4

# Opjectクラス以外のクラスを継承する場合は<を使う
# DVDクラスはProductクラスを継承する
class DVD < Product
end

# 7.6.5

class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
product = Product.new('A great movie', 1000)
product.name  #=> "A great movie"
product.price #=> 1000

class DVD < Product
  # nameとpriceはスーパークラスでattr_readerが設定されているので定義不要

  def initialize(name, price, running_time)
    # スーパークラスのinitializeメソッドを呼びだす
    suber(name, price)
    # DVDクラス独自の属性
    @running_time = running_time
  end
end
dvd = DVD.new('A great movie', 1000, 120)
dvd.name         #=> "A great movie"
dvd.price        #=> 1000
dvd.running_time #=> 120
# もしスーパークラスとサブクラスで処理が同じなのであれば同盟メソッドを定義する必要はない

# 7.6.6

# サブクラスにスーパークラスと同じ名前のメソッドを定義することで、スーパークラスの処理を上書きすることをメソッドのオーバーライドと呼ぶ
class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def to_s
    "name: #{name}, price: #{price}"
  end
end

class DVD < Product

  def initialize(name, price, running_time)
    suber(name, price)
    @running_time = running_time
  end

  def to_s
    # スーパークラスで用意されていない差分のみコーディングするだけで目的の処理を実装できる
    "#{super}, running_time: #{running_time}"
  end
end

dvd = DVD.new('An awesome film', 3000, 120)
dvd.to_s #=> "name: An awesome film, price: 3000, running_time: 120"

# 7.6.7

class Foo
  def self.hello
    'hello'
  end
end

class Bar < Foo
end

# Fooを継承したBarでもクラスメソッドのhelloが呼び出せる
Foo.hello #=> "hello"
Bar.hello #=> "hello"