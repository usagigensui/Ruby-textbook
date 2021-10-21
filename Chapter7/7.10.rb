# 7.10.1

# 独自に作成したクラスでも、aliasキーワードを使ってエイリアスメソッドを定義できる
# alias 新しい名前 元の名前
class User
  def hello
    'Hello!'
  end

  # helloメソッドのエイリアスメソッドとしてgreetingを定義する
  alias greeting hello
end
user = User.new
user.hello    #=> "Hello!"
user.greeting #=> "Hello!"

# 7.10.2

# メソッドの定義を後から削除する場合は、undefキーワードを使う
# undif 削除するメソッドの名前
class User
  # freezeメソッドの定義を削除
  undef freeze
end
user = User.new
# freezeメソッドを呼び出すとエラーになる

# 7.10.3

# クラスの内部に別のクラスを定義することができる
# クラスの内部に定義したクラスは::を使って参照する
# 外側のクラス::内側のクラス
class User
  class BloodType
    attr_reader :type
    
    def initialize(type)
      @type = type
    end
  end
end
blood_type = User::BloodType.new('B')
blood_type.type #=> "B"

# 7.10.4

# =で終わるメソッドのように、一見演算子を使っているようで実際はメソッドとして定義されているものがあり
# それらはクラスごとに再定義することができる
# | ^ & <=> == === =~ > >= < <= << >> + - * / % ** +@ -@ [] []= ` ! != !~

class Product
  attr_reader :code, :name
  
  def initialize(code, name)
    @code = code
    @name = name
  end

  # codeは商品コードで、nameは商品名
  # 商品コードが同じであれば==演算子でtrueを返してほしいが、
  # スーパークラスのObjectクラスでは==はobjecct_idが一致したときにtrueを返すので、想定した運用はできない
  # というわけで、Priductクラスで==を再定義(オーバーライド)する
  def ==(other)
    if other.is_a?(Product)
      # 商品コードが一致すれば同じProductと見なす
      code == other.code
    else
      # otherがProductでなければ常にfalse
      false
    end
  end
end

a = Product.new('A-0001', 'A great movie')
b = Product.new('B-0001', 'An awesome film')
c = Product.new('A-0001', 'A great movie')

a == b #=> false
a == c #=> true

# Product以外の比較はfalse
a == 1   #=> false
a == 'a' #=> false

# 7.10.5

# equal?メソッドはobject_idが等しい場合にtrueを返す
# このメソッドの挙動を変えるとプログラムの実行に悪影響を及ぼすのでequal?は再定義してはいけない
a = 'abc'
b = 'abc'
a.equal?(b) #=> false

c = a
a.equal?(c) #=> true

# ==はオブジェクトの内容が正しいかどうかを判断する
# 1 == 1.0がtrueになるように、データ型が違っても人間の目で見て自然であればtrueを返すように再定義することがある
1 == 1.0 #=> 1.0

# eql?メソッドはハッシュんおキーとして二つのオブジェクトが等しいかを判断する
# ==の結果で充分なケースが多いが、==では等値でもハッシュのキーとしては異なる値として扱う場合にeql?メソッドその要件を定義する
h = { 1 => 'Integer', 1.0 => 'Float' }
h[1]   #=> "Integer"
h[1.0] #=> "Float"
1.eql?(1.0) #=> false
# a.eql?(b)が真なら、a.hash == b.hashも真になるようにhashメソッドも再定義する必要がある


# case文では内部的に"when節のオブジェクト === case節のオブジェクト"の結果を評価している
value = [1, 2, 3]

# 内部的にはString === value、Array === value、Hash === valueの結果が評価されている
case value
when String
  puts '文字列です'
when Array
  puts '配列です'
when Hash
  puts 'ハッシュです'
end
#=> 配列です
# 独自に定義したクラスのオブジェクトをcase文のwhen節の中で使いたい場合は、===を要件に合わせて再定義する必要がある

# 7.10.6

# Rubyはクラスの継承に制限がなく、StringクラスやArrayクラスのような組み込みライブラリのクラスでの継承して独自のクラスを定義できる
# 定義済みのクラスそのものにメソッドを追加したり、メソッドの定義を上書きしたりできる
# Rubyのクラスは変更に対してオープンなので、「オープンクラス」と呼ばれる

# 既存のメソッドを上書きして自分が期待する挙動に変更することを「モンキーパッチ」と呼ぶ
class User
  def initialize(name)
    @name = name
  end

  def hello
    "Hello, #{@name}!"
  end
end
user = User.new('Alice')
user.hello #=> "Hello, Alice!"

# helloメソッドにモンキーパッチをあてる
class User
  def hello
    "#{@name}さん、こんにちは！"
  end
end
user.hello #=> "Aliceさん、こんにちは！"

# 応用として、既存のメソッドをエイリアスメソッドとして残し、上書きしたメソッドの中で既存のメソッドを再利用できる
class User
  def initialize(name)
    @name = name
  end

  def hello
    "Hello, #{@name}!"
  end
end

# モンキーパッチをあてるためにUserクラスを再オープン
class User
  # 既存のhelloメソッドを残すためにhello_originalとして呼び出せるようにする
  alias hello_original hello

  # helloメソッドにモンキーパッチをあてる
  # もともと実装されていたhelloメソッドも再利用する
  def hello
    "#{hello_original}じゃなくて、#{@name}さん、こんにちは！"
  end
end
user = User.new('Alice')
user.hello #=> "Aliceじゃなくて、Aliceさん、こんにちは！"

# 7.10.7

# オブジェクト.メソッド名という形でメソッドを定義すると、指定したオブジェクトにだけメソッドが追加される
# このように特定のオブジェクトにだけ紐付くメソッドを特異メソッドと呼ぶ
# 特異メソッドは数値やシンボルには定義できない

alice = 'I am Alice.'
bob = 'I am Bob.'

def alice.shuffle
  chars.shuffle.join
end

alice.shuffle #=> ".al cImeiA"
# bobでshuffleメソッドは使えずエラーする

# 7.10.8

# 便宜上クラスメソッドと呼ばれているものは、実際は特定のクラスの特異メソッド
# APIドキュメントにはクラスメソッドという用語はなく特異メソッドとして説明されている

# 7.10.9

# Rubyは動的型付け言語なので、事前に実行可能なコードか実証せず、あくまでそのメソッドが呼び出せるかどうかを評価する
# オブジェクトのクラスが何であろうとそのメソッドが呼び出せれば良しとするプログラミングをダックプログラミングと呼ぶ

# Column

# respond_to?メソッドはそのオブジェクトが特定のメソッドを呼び出し可能か確認できる
s = 'Alice'
# Stringクラスはsplitメソッドを持つ
s.respond_to?(:split) #=> true
# nameメソッドは持たない
s.respond_to?(:name) #=> false