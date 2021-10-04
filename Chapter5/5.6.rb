# 5.6.1

currencies = { japan: 'yen',  us: 'dollar', india: 'rupee'}

# keysメソッドはハッシュのキーを配列として返す
currencies.keys #=> [:japan, :us, :india]
# valuesメソッドはハッシュの値を配列として返す
currencies.values #=> ["yen", "dollar", "rupee"]
# has_key?メソッドはハッシュの中に指定されたキーが存在するか確認する(key?、include?、member?がエイリアスメソッド)
currencies.has_key?(:japan) #=> true
currencies.has_key?(:italy) #=> false

# 5.6.2

h = { us: 'dollar', india: 'rupee' }
# **をハッシュの前につけるとハッシュリテラル内でキーと値を展開する
{ japan: 'yen', **h } #=> {:japan=>"yen", :us=>"dollar", :india=>"rupee"}
# mergeメソッドを使っても同じ効果が得られる
{ japan: 'yen' }.merge(h) #=> {:japan=>"yen", :us=>"dollar", :india=>"rupee"}

# 5.6.3

# ハッシュを引数として受け取り、擬似キーワード引数を実現する
def buy_burger(menu. options = {})
  drink = options[:drink]
  potato = options[:potato]
  # 省略
end

buy_burger('cheese', drink: true, potato: true)

# 5.6.4

# キーワード引数を使うメソッドに存在しないキーワードを渡すとエラーする
# 任意のキーワードも同時に受け取りたい場合は**をつけた引数を最後に用意する
# 想定外のキーワードはothers引数で受け取る
def buy_burger(nenu, drink: true, potato: true, **others)
  # othersはハッシュとして渡される
  puts others

  # 省略
end

buy_burger('fish', drink: true, potato: false, salad: true, chicken: false)
#=> {:salad=>true, :chicken=>false}

# 5.6.5

# 最後の引数がハッシュであればハッシュリテラルの{}を省略できる
def buy_burger(menu, options = {})
  puts options
end
buy_burger('fish', 'drink' => true, 'potato' => false) #=> {"drink"=>true, "potato"=>false}

# 5.6.7

# ハッシュにto_aメソッドを使うと配列に変換することができる
currencies = { japan: 'yen', us: 'dollar', india: 'rupee'}
currencies.to_a #=> [[:japan, "yen"], [:us, "dpllar"], [:india, "rupee"]]

# 配列に対してto_hメソッドを使うと、ハッシュに変換することができる
array = [[:japan, "yen"], [:us, "dpllar"], [:india, "rupee"]]
array.to_h #=> {:japan=>"yen", :us=>"dollar", :india=>"rupee"}
# キーが重複すると最後に登場した値のみ採用されるので注意

# to_hを使わず、Hash[]に配列を渡すことで同じ効果が得られる
array = [[:japan, "yen"], [:us, "dpllar"], [:india, "rupee"]]
Hash[array] #=> {:japan=>"yen", :us=>"dollar", :india=>"rupee"}

# 5.6.8

# ハッシュに対して存在しないキーを指定するとnilが返る
h = {}
h[:foo] #=> nil

# Hash.newでハッシュを作成し、引数に初期値を指定できる
h = Hash.new('hello')
h[:foo] #=> 'hello
# ハッシュ自身は空のまま
h #=> {}

# Hadh.newにブロックを与えると、ブロック引数としてハッシュ自信と見つからなかったキーが渡される
# 初期値を返すだけでなく、ハッシュに指定されたキーと初期値を同時に設定する
h = Hash.new { |hash, key| hash[key] = 'hello' }
h[:foo] #=> "hello"
h[:bar] #=> "hello"

h #=> {:foo=>"hello", :bar=>"hello"}