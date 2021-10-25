# 8.5.1

# クラスに特定のモジュールがincludeされているかを確認するには、include?メソッドを使う
module Loggable
  # 省略
end

class Product
  include Loggable
  # 省略
end

Product.include?(Loggable) #=> true

# included_modulesメソッドはincludeされているモジュールの配列が返る
Product.included_modules #=> [Loggable, Kernel]

# ancestorsメソッドを使うと、モジュールだけでなくスーパークラスの情報も配列になって返る
Product.ancestors #=> [Product, Loggable, Object, Kernel, BasicObject]

# クラスオブジェクトだけではなく、クラスのインスタンスからもincludeされているモジュールの情報は取得できる
product = Product.new
# product.classはProductクラスを返す
product.class.include?(Loggable) #=> true
product.class.included_modules   #=> [Loggable, Kernel]

# is_a?メソッドを使えば、直接インスタンスに対してそのモジュールをincludeしているかわかる
product = Product.new
# 引数が自クラス、includeしているモジュール、スーパークラスのいずれかに該当すればtrue
product.is_a?(Product)  #=> true
product.is_a?(Loggable) #=> true
product.is_a?(Object)   #=> true

# 8.5.2

# Rubyは「メソッドを実行する瞬間にそのメソッドを呼び出せればよい」という考え方でプログラムが書ける
module Taggable
  def price_tag
    # priceメソッドはinclude先で定義されているはず、という前提
    "#{price}円"
  end
end

class Product
  include Taggable

  def price
    1000
  end
end

product = Product.new
product.price_tag #=> "1000円"

# 8.5.3

# Enumerableモジュールは配列やハッシュ、範囲など、何かしらの繰り返し処理ができるクラスにincludeされているモジュール
Array.include?(Enumerable) #=> true
Hash.include?(Enumerable)  #=> true
Range.include?(Enumerable) #=> true

# Enumerableモジュールには「map」「select」「find」「count」等50以上のメソッドが定義されている
# 自分で定義したクラスでもeachメソッドが実装されていれば、Enumerableをincludeするだけでこのモジュールに定義されたメソッドが使えるようになる

# 8.5.4

# Comparableモジュールは、比較演算を可能にするモジュール
# Comparableモジュールをincludeすると、「<」「<=」「==」「>」「>=」「between?」が使えるようになる
# Comparableモジュールのメソッドを使うには、include先のクラスで<=>演算子(UFO演算子)を実装しておくこと

  # a <=> bの場合
    # aがbより大きいなら正の整数
    # aとbが等しいなら0
    # aがbより小さいなら負の整数
    # aとbが比較できない場合はnil

2 <=> 1     #=> 1
2 <=> 2     #=> 0
1 <=> 2     #=> -1
2 <=> 'abc' #=> nil

'xyz' <=> 'abc' #=> 1
'abc' <=> 'abc' #=> 0
'abc' <=> 'xyz' #=> -1
'abc' <=> 123   #=> nil

# 音楽のテンポ(曲の速さ)を表すクラスを作る
class Tempo
  include Conparable
  
  attr_reader :bpm

  def initialize(bpm)
    @bpm = bpm
  end

  # <=>はComparableモジュールで使われる演算子(メソッド)
  def <=>(other)
    if other.is_a?(Tempo)
      # bpm同士を<=>で比較した結果を返す
      bpm <=> other.bpm
    else
      # 比較できない場合はnilを返す
      nil
    end
  end

  # 見やすくするためにinspectをオーバーライド
  def inspect
    "#{bom}bpm"
  end
end

t_120 = Tempo.new(120) #=> 120bpm
t_180 = Tempo.new(180) #=> 180bpm

t_120 > t_180  #=> false
t_120 <= t_180 #=> true
t_120 == t_180 #=> false

# <=>演算子は並び替えを行うときにもよく使われる
tempos = [Tempo.new(180), Tempo.new(60), Tempo.new(120)]
# sortメソッドの内部でｈあ並び替えの時に<=>演算子が使われる
tempos.sort #=> [60bpm, 120bpm, 18bpm]

# 8.5.5

# 「puts」「p」「print」「require」「loop」等のような、メソッドの多くがKernelモジュールから提供されている
# ObjectクラスがKernelモジュールをincludeしているので、Kernelモジュールのメソッドはどこでも使える
Object.include?(Kernel) #=> true

# 8.5.6

# Rubyではクラス構文やモジュール構文に囲まれていない一番外側の部分のことをトップレベルという
# トップレベルはmainという名前のObjectクラスのインスタンスになる

p self       #=> main
p self.class #=> Object

class User
  # ここはクラスの内部
  p self       #=> User
  p self.class #=> Class
end

# 8.5.7

# Rubyはすべてがオブジェクトなので、StringクラスやKernelモジュールもすべてオブジェクト
# クラスはClassクラスのインスタンス、モジュールはModuleクラスのインスタンス
# さらにClassクラスもModuleクラスもObjectクラスを継承している

class User
  p self       #=> User
  p self.class #=> Class
end

User.class #=> Class
  
Class.superclass #=> Module

module Loggable
  p self       #=> Loggable
  p self.class #=> Module
end

Loggable.class #=> Module

Module.superclass #=> Object

# 8.5.8

module NameChanger
  def change_name
    self.name = 'ありす'
  end
end

class User
  include NameChanger

  # ゲッターメソッドとセッターメソッドを用意する
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

user = User.new('alice')
user.name #=> "alice"

user.change_name
user.name #=> "ありす"

# 8.5.9

module Loggable
  def log(text)
    puts "[LOG] #{text}"
  end
end

s = 'abc'

# 文字列は通常logメソッドを持たない
# 文字列sにLoggableモジュールのメソッドを特異メソッドとしてミックスインする
s.extend(Loggable)

# Loggableモジュールのlogメソッドが呼び出せるようになる
s.log('Hello.') #=> [LOG] Hello.