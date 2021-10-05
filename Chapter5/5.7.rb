# 5.7.1

# 識別子として無効な文字列(数字始まりや、ハイフンやスペース交じり)でも、シングルクオートで囲むとシンボルとして有効になる
:'12345'
:'ruby-is-fun'
:'ruby is fun'
:'()'

# ダブルクオートを使うと文字列と同じく式展開を使える
name = 'Alice'
:"#{name.upcase}" #=> :ALICE

# "文字列: 値"の形式で書いた場合も、":文字列"と同じようにキーがシンボルになる
hash = { 'abc': 123 } #=> {:abc=>123}

# 5.7.2

# %記法でシンボルを作成することもできる。シンボルを作成する場合は%sを使う
%s!ruby is fun! #=> :"ruby is fun"
%s(ruby is fun) #=> :"ruby is fun"

# シンボルの配列を作成する場合は%iを使う
%i(apple orange melon) #=> [:apple, :orange, :melon]

# 改行文字を含めたり、式展開する場合は%Iを使う
name = 'Alice'
%I(hello\ngood-bye #{name.upcase}) #=> [:"hello\ngood-bye", :ALICE]

# 5.7.3

# to_symメソッド(エイリアスメソッドはintern)で文字列をシンボルに変換する
string = 'apple'
symbol = :apple
string.to_sym #=> :apple

# to_sメソッド(エイリアスメソッドはid2name)でシンボルを文字列に変換する
string = 'apple'
symbol = :apple
symbol.to_s #=> "apple"

# respond_to?メソッドはオブジェクトに対して文字列またはシンボルで指定したメソッドを呼び出せるか調べる
'apple'.respond_to?('include?') #=> true
'apple'.respond_to?(:include?)  #=> true

# Column

# 国名に応じて通貨を返す(該当する通貨がなければnil)
def find_currency(country)
  currencies = { japan: 'yen', us: 'dollar', india: 'rupee' }
  currencies[country]
end

# 指定された国の通貨を大文字にして返す
def show_currency(country)
  currency = find_currency(country)
  # &.演算子(ぼっち演算子)を使ってメソッドを呼び出すと、nilだった場合はnilを返す
  # upcaseメソッドはnilだとエラーが起こるので、&.演算子を使って呼び出す
  currency&.upcase
end

show_currency(:japan)  #=> "YEN"
show_currency(:brazil) #=> nil

# Column

# 変数limitがnilまたはfalseであれば10を代入する
limit ||= 10

limit = nil
limit ||= 10
limit #=> 10

limit = 20
limit ||= 10
limit #=> 20

# Column

def user_exists?
  # データベースなどからユーザを探す
  user = find_user
  if user
    # userが見つかったのでtrue
    true
  else
    # userが見つからないのでfalse
    false
  end
end

# 上記のコードは下記のように短くできる
def user_exists
  !!find_user
end
# !は否定の演算子で、find_userが真であればfalseを返すが、それをもう一度!で反転させると、userに対する真偽値が得られる