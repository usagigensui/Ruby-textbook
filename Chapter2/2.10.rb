# 2.10.1

# &&や||の式の戻り値は必ずしもtrueまたはfalseになるとは限らない
puts 1 && 2 && 3 #=> 3
puts 1 && nil && 3 #=> nil
puts 1 && false && 3 #=> false
puts nil || false || nil #=> nil
puts false || nil #=> nil
puts nil || false || 2 || 3 #=> 2
# Rubyは式全体が真か偽か確定するまで左辺から順に評価する
# 真か偽かが確定するとその時点での式の評価は終了し、最後に評価した値を返す

# Alice、Bob、Carolと順に検索し、最初に見つかったユーザー(nilまたはfalse以外の値)を変数に格納する
user = find_user('Alice') || find_user('Bob') || find_user('Carol')

# 正常なユーザーであればメールを送信する(左辺が偽であればメール送信は実行されない)
user.valid? && send_email_to(user)

# 2.10.2

# 英語の論理演算子(&&、||、!と近い動きをする)
t1 = true
f1 = false
t1 and f1 #=> false
t1 or f1  #=> true
not t1    #=> false

# 英語の論理演算式と記号の論理演算子では記号のほうが優先度が高い
t1 = true
f1 = false
!f1 || t1    #=> true
not f1 || t1 #=> false

# &&、||と異なり、andとorは優先順位が同じなので、左から右に評価される
t1 = true
t2 = true
f1 = false
t1 || t2 && f1 #=> true
t1 or t2 and f1 #=> false

# andはやorは条件分岐ではなく制御フローを扱うのに向く
user.valid? and send_email_to user

# orは「Aは真か？　真でなければBせよ」という制御フローを実現する際に便利
def greeting(country)
  # countryがnil(またはfalse)ならメッセージを返してメソッドを抜ける
  country or return 'countryを入力してください'

  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end
greeting(nil) #=> "countryを入力してください"
greeting('japan') #=> "こんにちは"

# 2.10.3

# unless文んはif文と反対に、条件式が偽の場合に処理を実行する
status = 'ok'
unless status == 'ok'
  '何か異常があります'
else
  '正常です'
end
#=> "正常です"

# if文のelsifに相当するものは存在しない
# ifと同様、unllesの戻り値を直接変数に代入したり、修飾子として分の後ろに置いたりできる
status = 'error'

# unllessの結果を変数に代入する
message =
  unless status == 'ok'
    '何か異常があります'
  else
    '正常です'
  end

message #=> '何か異常があります'

# unllessを修飾子として使う
'何か異常があります' unless status == 'ok'
#=> '何か異常があります'

# thenを入れることもできる
status = 'error'
unless status == 'ok' then
  '何か異常があります'
end
#=> '何か異常があります'

# 2.10.4

country = 'italy'

# if文を使う場合
if country == 'japan'
  'こんにちは'
elsif country == 'us'
  'Hello'
elsif country == 'italy'
  'ciao'
else
  '???'
end
#=> "ciao"

# case文を使う場合
case country
when 'japan'
  'こんにちは'
when 'us'
  'Hello'
when 'italy'
  'ciao'
else
  '???'
end
#=> "ciao"

# Rubyのcase文ではwhen節に複数の値を指定し、どれかに一致すれば処理を実行するという条件分岐を書ける
country = 'アメリカ'
case country
when 'japan', '日本'
  'こんにちは'
when 'us', 'アメリカ'
  'Hello'
when 'italy', 'イタリア'
  'ciao'
else
  '???'
end
#=> "Hello"

# if文と同様、case文の結果を変数に格納できる
country = 'italy'
message =
  when 'japan'
    'こんにちは'
  when 'us'
    'Hello'
  when 'italy'
    'ciao'
  else
    '???'
  end
message #=> "ciao"

# thenを入れるとwhen節とその条件が真だった場合の処理を1行で記述できる
country = 'italy'
when 'japan' then 'こんにちは'
when 'us' then 'Hello'
when 'italy' then 'ciao'
else '???'
end
#=> "ciao"

# 2.10.5

# C言語と同様?を使った三行演算子が使える
# 式 ? 真だった場合の処理 : 偽だった場合の処理
n = 11
n > 10 ? '10より大きい' : '10以下'
#=> "10より大きい"

# 条件仏器した結果を変数に代入できる
n = 11
message = n > 10 ? '10より大きい' : '10以下'
message #=> "10より大きい"