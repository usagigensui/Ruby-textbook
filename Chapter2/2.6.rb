# 2つの数字を加算するメソッド
def add(a, b)
  a + b
end
add(1, 2) #=> 3

# メソッド名はスネークケースで書く(キャメルケースは使わない)
# 数字から始まるメソッド名は使えない
def hello_world
  'Hello, world'
end

# メソッド名をひらがなにする(一般的ではない)
def あいさつする
  'はろー、わーるど！'
end
あいさつする #=> 'はろー、わーるど！'

# 2.6.1

# Rubyは最後に評価された値が戻り値になるのでreturnは使わないほうが主流
def add(a, b)
  return a + b
end
add(1, 2) #=> 3

def greeting(country)
  # "こんにちは"または"hello"が戻り値になる
  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end
greeting('japan') #=> 'こんにちは'
greeting('us')    #=> 'hello'

# returnは、メソッドを途中で脱出する場合に使われることが多い
def greeting(country)
  # countryがnilならメッセージを返してメソッドを抜ける
  # nil?はオブジェクトがnilの時にtrueを返すメソッド
  return 'countryを入力してください' if country.nil?

  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end
greeting(nil)     #=> "countryを入力してください"
greeting('japan') #=> "こんにちは"

# 2.6.2

# 引数のないメソッドは()をつけないほうが主流(つけても動く)
def greeting
  'こんにちは'
end