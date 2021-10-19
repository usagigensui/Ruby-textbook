# 7.7.1

# publicメソッドはクラスの外部からでも自由に呼び出せるメソッド

class User
  def hello
    'Hello!'
  end
end
user = User.new
# publicメソッドなのでクラスの外部から呼び出せる
user.hello #=> "Hello"

# 7.7.2

# privateメソッドはクラスの内部のみで使えるメソッド
# 厳密には「レシーバを指定して呼び出すことができないメソッド」
class User
  def hello
    # もしself.nameと呼び出すとエラーする
    "Hello!, I am #{name}."
  end

  # ここから下で定義されたメソッドはprivate
  private

  def name
    'Alice'
  end
end
user = User.new
user.hello #=> "Hello!, I am Alice."
# helloメソッドはprivateメソッドなのでクラスの外部からは呼び出せない

# 7.7.3

# privateメソッドはサブクラスでも呼び出せる
class Product
  private
  
  def name
    'A great movie'
  end
end

class DVD < Product
  def to_s
    # nameはスーパークラスのprivateメソッド
    "name: #{name}"
  end
end

dvd = DVD.new
dvd.to_s #=> "name: A great movie"

# 7.7.4

# クラスメソッドはprivateの下に書いてもprivateにならないので注意
class User
  private

  def self.hello
    'Hello!'
  end
end
User.hello #=> "Hello!"

# クラスメソッドをprivateにする場合はclass << selfの構文を使う
class User
  class << self
    private

    def hello
      'Hello!'
    end
  end
end

# もしくはprivate_class_methodでクラスメソッドの定義後に公開レベルを変更できる
class User
  def self.hello
    'Hello!'
  end
  private_class_method :hello
end

# 7.7.6

# privateに引数を渡すと、そのメソッドがprivateになる
class User
  def foo
    'foo'
  end

  def bar
    'bar'
  end

  # fooとbarをprivateメソッドに変更
  private :foo, :bar

  def baz
    'baz'
  end
end

user = User.new
# bazメソッドのみpublicなので呼び出せる
user.baz #=> "baz"

# 7.7.7

# protectedメソッドは、定義したクラス自身とそのサブクラスのインスタンスメソッドからレシーバ付きで呼び出せる
class User
  # weightは外部に公開しない
  attr_reader :name

  def initialize(name, weight)
    @name = name
    @weight = weight
  end
  
  def heavier_than?(other_user)
    other_user.weight < @weight
  end

  protected

  def weight
    @weight
  end
end
alice = User.new('Alice', 50)
bob = User.new('Bob', 60)
alice.heavier_than?(bob) #=> false