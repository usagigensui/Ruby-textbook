# 8.3.1

# is-aの関係が成り立たない(継承するにはふさわしくない)が、共通の機能を別のクラスに持たせたい場合は、
# モジュールに必要な機能を持たせたメソッドを定義し、クラスでそのモジュールをincludeすると
# モジュールで定義したメソッドがインスタンスメソッドとして呼び出せる

# ログ出力用のメソッドを提供するモジュール
# 「ログ出力できる(log + able)」という意味でLoggableという名前をつけた
module Loggable
  # クラスの外から使用する必要がないのでprivateにする
  private

  def log(text)
    puts "[LOG] #{text}"
  end
end

class Product
  # 上で作ったモジュールをincludeする
  include Loggable

  def title
    # logメソッドはLoggableモジュールで定義したメソッド
    log 'title is colled.'
    'A great movie'
  end
end

class User
  # こちらも同じようにincludeする
  include Loggable
  
  def name
    # Loggableモジュールのメソッドが使える
    log 'name is called.'
    'Alice'
  end
end

product = Product.new
product.title
#=> [LOG] title is colled.
#   "A great movie"

user = User.new
user.name
#=> [LOG] name is called.
#   "Alice"

# モジュールをクラスにincludeして機能を追加することをミックスインという

# 8.3.2

# extendを使うとモジュール内のメソッドをそのクラスの特異メソッド(つまりクラスメソッド)にできる

module Loggable
  def log(text)
    puts "[LOG] #{text}"
  end
end

class Product
  # 上で作ったモジュールをincludeする
  extend Loggable

  def self.create_products(names)
    # logメソッドをクラスメソッド内で呼び出す
    log 'create_products is colled.'
  end

  # クラス構文の直下でもlogメソッドを使うことができる
  log 'Defined Product class.'
end
#=> [LOG] Defined Product class.

# クラスメソッド経由でlogメソッドが呼び出される
Product.create_products([]) #=> [LOG] create_products is colled.

# Productクラスのクラスメソッドとして直接呼び出すこともできる
Product.log('Hello.') #=> [LOG] Hello.