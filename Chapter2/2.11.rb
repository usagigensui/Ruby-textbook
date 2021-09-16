# 2.11.1

# 引数にデフォルト値をつける
# メソッド(引数1 = デフォルト値1, 引数2 = デフォルト値2)
def greeting(country = 'japan')
  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end
greeting #=> "こんにちは"
greeting('us') #=> "hello"

# デフォルト値ありとデフォルト値なしの引数を混在させることもできる
def default_args(a, b, c = 0, d = 0)
  "a=#{a}, b=#{b}, c=#{c}, d=#{d}"
end
default_args(1, 2)       #=> "a=1, b=2, c=0, d=0"
default_args(1, 2, 3)    #=> "a=1, b=2, c=3, d=0"
default_args(1, 2, 3, 4) #=> "a=1, b=2, c=3, d=4"

# デフォルト値は動的な値や、他のメソッドの戻り値を指定することもできる
def foo(time = Time.now, message = bar)
  puts "time: #{time}, message: #{message}"
end

def bar
  'BAR'
end

foo #=> time: 2021-09-15 23:50:59 +0900, message: BAR

# 2.11.2

# Rubyのメソッドは?や!で終わらせることができる
# ?で終わるメソッドは慣習として真偽値を返す

# Rubyに最初から用意されているメソッド

# 空文字列であればtrue、そうでなければfalse
''.empty?    #=> true
'abc'.empty? #=> false

# 引数の文字列が含まれていればtrue、そうでなければfalse
'watch'.include?('at') #=> true
'watch'.include?('in') #=> false

# 奇数ならtrue、偶数ならfalse
1.odd? #=> true
2.odd? #=> false

# 偶数ならtrue、奇数ならfalse
1.even? #=> false
2.even? #=> true

# オブジェクトがnilであればtrue、そうでなければfalse
nil.nil? #=> true
'abc'.nil? #=> false
1.nil? #=> false

# ?で終わるメソッドは自作することもできる
def multiple_of_three?(n)
  n % 3 == 0
end
multiple_of_three(4) #=> false
multiple_of_three(5) #=> false
multiple_of_three(6) #=> true

# 2.11.3

# !で終わるメソッドは慣習として注意が必要という意味を持つ

a = 'ruby'

# upcaseだと変数aの値は変化しない
a.upcase #=> "RUBY"
a        #=> "ruby"

# upcase!だと変数aの値も大文字に変わる
a.upcase! #=> "RUBY"
a         #=> "RUBY"

# upcase!のように呼び出したオブジェクトの状態を変更するメソッドを破壊的メソッドと呼ぶ

# ?と同様!で終わるメソッドも自分で定義できる
def reverse_upcase!(s)
  s.reverse!.upcase!
end
s = 'ruby'
reverse_upcase!(s) #=> "YBUR"
s #=> "YBUR"
