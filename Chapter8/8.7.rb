# 8.7.1

# モジュール単体で呼び出したいメソッドを定義する場合は、モジュールに特異メソッドを定義する
module Longgable
  # 特異メソッドとしてメソッドを定義する
  def self.log(text)
    puts "[LOG] #{text}"
  end
end

Loggable.log('Hello.') #=> [LOG] Hello.

# モジュールの特異メソッドは、newする必要がまったうない「単なるメソッドの集まり」を作りたいケースに向いている
# モジュールでもクラスと同様にclass << selfを使って特異メソッドを定義できる
module Longgable
  class << self
    def log
      puts "[LOG] #{text}"
    end

    # 以下、他の特異メソッドを定義
  end
end

Loggable.log('Hello.') #=> [LOG] Hello.

# 8.7.2

# module_functionメソッドを使うと、ミックスインとしても、モジュールの特異メソッドとしても使えるメソッドを定義できる
module Longgable
  def self.log(text)
    puts "[LOG] #{text}"
  end
  # logメソッドを定義をミックスインとしても、モジュールの特異メソッドとしても使えるようにする
  # (module_functionは対象メソッドの定義よりも下で呼び出すこと)
  module_function :log
end

Loggable.log('Hello.') #=> [LOG] Hello.

# Loggableモジュールをincludeしたクラスを定義する
class Product
  include Loggable

  def title
    # includeしたLoggableモジュールのlogメソッドを呼び出す
    log 'title is called.'
    'A great movie'
  end
end
# こいったミックスインとしてもモジュールの特異メソッドとしても使えるメソッドをモジュール関数という

# module_functionを引数なしで呼び出した場合はそこから下に定義されたメソッドがすべてモジュール関数になる
module Loggable
  # ここから下のメソッドはすべてモジュール関数
  module_function

  def log(text)
    puts "[LOG} #{text}"
  end
end

# 8.7.3

# モジュールにも定数を定義できる
module Loggable
  # 定数を定義する
  PREFIX = '[LOG]'.freeze

  def log(text)
    puts "#{PREFIX} #{text}"
  end
end

# 定数を参照する
Loggable::PREFIX #=> "[LOG]"

# 8.7.4

# Mathモジュールは組み込みライブラリのひとつで、数学の計算でよく使われる関数が多く定義されている

# モジュールの特異メソッドとしてsprt(平方根)メソッドを利用する
Math.sqrt(2) #=> 1.41422134523730951

class Calulator
  include Math

  def calc_sqrt(n)
    # ミックスインとしてMathモジュールのsqrtメソッドを使う
    sqrt(n)
  end
end

calculator = Calulator.new
calculator.calc_sqrt(2) #=> 1.4142134523730951

# Karnelモジュールの特異メソッドとしてputsやpを呼び出す
Kernel.puts "Hello." #=> Hello.
Kernel.p [1, 2, 3]   #=> [1, 2, 3]