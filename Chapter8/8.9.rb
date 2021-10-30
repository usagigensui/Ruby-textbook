# 8.9.1

# メソッドの呼び出し順
module A
  def to_s
    "<A> #{super}"
  end
end

module B
  def to_s
    "<B> #{super}"
  end
end

class Product
  def to_s
    "<Product> #{super}"
  end
end

class DVD < Product
  include A
  include B
    
  def to_s
    "<DVD> #{super}"
  end
end

dvd = DVD.new
dvd.to_s #=> "<DVD> <B> <A> <Product> #<DVD:0x00000228c9309528>"

# 8.9.2

# includeはクラス定義だけでなく、モジュール定義の中で呼び出すこともできる
# また、あるモジュールをincludeすれば、「そのモジュールがincludeしているモジュール」もincludeしたことになる
module Greeting
  def hello
    'hello.'
  end
end

module Aisatsu
  # 別のモジュールをincludeする
  include Greeting
  
  def konnichiwa
    'こんにちは。'
  end
end

class User
  # Aisatsuモジュールだけをincludesuru
  include Aisatsu
end

usar = User.new

# Aisatsuモジュールのメソッドを呼び出す
usar.konnichiwa #=> "こんにちは。"

# Greetingモジュールのメソッドを呼び出す
usar.hello #=> "hello."

# 8.9.3

# prependでミックスインすると、同名のメソッドがあったときに、ミックスインしたクラスよりも先にモジュールのメソッドが呼ばれる

module A
  def to_s
    "<A> #{super}"
  end
end

class Product
  # includeではなくprependを使う
  prepend A

  def to_s
    "<Product> #{super}"
  end
end

product = Product.new
product.to_s #=> "<A> <Product> #<Product:0x000002b7316142d0>"

# prependではなくincludeでモジュールをミックスインした場合
product.to_s #=> "<Product> <A> #<Product:0x000002b7316142d0>"

# 8.9.4

# prependを使った既存メソッドの置き換えの例

# 以下のProductクラスは外部ライブラリで定義されている想定
class Product
  def name
    "A great film"
  end
end

module NameDecorator
  def name
    "<<#{super}>>"
  end
end

class Product
  prepend NameDecorator
end

product = Product.new
product.name #=> "<<A great film>>"

# 8.9.5

# refinementsを使うと独自の変更をしたメソッドの有効範囲（スコープ）を限定することができる
module StringShuffle
  # refinementsが目的なので、refineメソッドを使う
  refine String do
    def shuffle
      chars.shuffle.join
    end
  end
end

# 通常はStringクラスにshuffleメソッドはないが、Userクラスの内部においてのみ有効にする
class User
  # refinementsを有効化する
  using StringShuffle
  
  def initialize(name)
    @name = name
  end

  def shuffled_name
    # Userクラスの内部であればStringクラスのshuffleメソッドが有効になる
    @name.shuffle
  end

  # Userクラスを抜けるとrefinementsは無効になる
end

user = User.new('Alice')
# Userクラス内ではshuffleメソッドが有効になっている
user.shuffled_name #=> "cliAe"

# refinementsで使うモジュールの内部には、複数のrefineを定義することができる
module SomeModule
  refine Object do
    # Objectクラスに対する変更
  end

  refine String do
    # Stringクラスに対する変更
  end
end

# モジュールに対する変更も可能
module SomeModule
  refine Enumerable do
    # Enumerableモジュールに対する変更
  end
end

# Column

# メソッド呼び出しは、ドットだけではなく二重コロンを使うこともできる
s = 'abc'
s.upcase  #=> "ABC"
s::upcase #=> "ABC"
# ただし、ドットで名前空間を区切ったり定数を参照することはできない（ドットの右辺は必ずメソッド）