# 7.3.1

# Userクラスの定義
class User
  # newメソッドを呼び出すと、initializeメソッドが呼び出される
  # インスタンスを初期化するために実行したい処理があればinitializeメソッドに処理を実装する
  # とくに必要がなければ定義しなくてもよい
  def initialize
    puts 'Initialized.'
  end
end
User.new
#=> Initialized.

class User
  # newメソッドに引数をつけると、newメソッドを呼ぶときにも引数が必要になる
  def initialize(name, age)
    puts "name: #{name}, age: #{age}"
  end
end
User.new('Alice', 20) #=> name: Alice, age: 20

# 7.3.2

class User
  # クラス構文の内部でメソッドを定義すると、そのメソッドはインスタンスメソッドになる
  # インスタンスメソッドはそのクラスのインスタンスに対して呼び出すことができる
  def hello
    "Hello!"
  end
end
user = User.new
# インスタンスメソッドの呼び出し
user.hello #=> "Hello!"

# 7.3.3

# クラスの内部ではインスタンス変数を使うことができる
# インスタンス変数は同じインスタンス(オブジェクト)の内部で共有される
# インスタンス変数の変数名は@で始める
class User
  def initialize(name)
    # インスタンス作成時に渡された名前をインスタンス変数に保存する
    @name = name
  end
  def hello
    # インスタンス変数に保存されている名前を表示する
    "Hello, I am #{@name}"
  end
end
user = User.new('Alice')
user.hello #=> "Hello, I am Alice."

# メソッドやブロックの内部で作成される変数をローカル変数と呼ぶ
# ローカル変数はメソッドやブロックの内部でのみ有効で、メソッドやブロックが呼び出されるたび作り直される
# ローカル変数はアルファベットの小文字、またはアンダースコアで始める

# インスタンス変数を外部から変更したい場合は変更用のメソッドを定義する
# =で終わるメソッドを定義すると、変数に代入するような形式でそのメソッドを呼び出せる
class User
  def initialize(name)
    @name = name
  end

  # @nameを外部から参照するためのメソッド
  def name
    @name
  end

  # @nameを外部から変更するためのメソッド
  def name=(value)
    @name = value
  end
end
user = User.new('Alice')
# 変数に代入しているように見えるが、実際はname=メソッドを呼び出している
User.name = 'Bob'
User.name #=> "Bob"

# インスタンス変数の値を読み書きするメソッドのことを「アクセサメソッド」と呼ぶ
# 単純にインスタンス変数の内容を外部から読み書きするのであれば、attr_accessorメソッドを使ってメソッド定義を省略できる
class User
  # @nameを読み書きするメソッドが自動的に定義される
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end

  # nameメソッドやname=メソッドを明示的に定義する必要がない
end
user = User.new('Alice')
# @nameを変更する
User.name = 'Bob'
# @nameを参照する
User.name #=> "Bob"

# 読み取り専用にしたい場合はattr_readerメソッドを使う
# 書き込み専用にしたい場合はattr_writerメソッドを使う

# カンマで複数の引数を渡すと、複数のインスタンス変数に対するアクセサメソッドを作成する
class User
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end
user = User.new('Alice', 20)
User.name #=> "Alice"
User.age #=> 20

# 7.3.4

# クラスに関連は深いものの、ひとつひとつのインスタンスに含まれるデータは使わないメソッドはクラスメソッドを定義したほうがよい
class User
  def initialize(name)
    @name = name
  end

  # self.をつけるとクラスメソッドになる
  def self.create_users(names)
    names.map do |name|
      User.new(name)
    end
  end

  # これはインスタンスメソッド
  def hello
    "Hello, I am #{@name}"
  end
end
names = ['Alice', 'Bob', 'Carol']
# クラスメソッドの呼び出し
users = User.create_users(names)
users.each do |user|
  # インスタンスメソッドの呼び出し
  puts user.hello
end
#=> Hello, I am Alice.
#   Hello, I am Bob.
#   Hello, I am Carol.

# 7.3.5

# クラスの中に定数を定義することもできる
# 定数は必ず大文字ではじめる必要がある。慣習的に大文字と数字とアンダースコアで構成されることが多い
class Product
  # デフォルトの値を定数として定義する
  DEFAULT_PRICE = 0

  attr_reader :name, :price

  def initialize(name, price = DEFAULT_PRICE)
    @name = name
    @price = price
  end
end
product = Product.new('A free movie')
product.price #=> 0

# 定数はインスタンスメソッドでもクラスメソッドでの同じ方法で参照できる
class Product
  DEFAULT_PRICE = 0

  def self.default_price
    # クラスメソッドから定数を参照
    DEFAULT_PRICE
  end

  def default_price
    # インスタンスメソッドから定数を参照
    DEFAULT_PRICE
  end
end

Product.default_price #=> 0

product = Product.new
product.default_price #=> 0