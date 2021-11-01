# 9.2.1

# Ruubyはコードを上から実行していきエラーが発生した時点でプログラムが終了する

# 9.2.2

# 例外(エラー)が発生してもエラーを続行したい場合は例外処理を明示的に書く
# begin
#   例外が起きうる処理
# rescue
#   例外が発生した場合の処理
# end

puts 'Start.'
module Greeter
  def hello
    'hello'
  end
end

# 例外処理を組み込んで例外に対処する
begin
  greeter = Greeter.new
rescue
  puts '例外が発生したが、このまま実行する'
end

# 例外処理を組み込んだので、最後まで実行可能
puts 'End.'

# 9.2.3

# begin~rescueは例外処理を囲む必要がある
# 例外が発生すると、そこで処理を中断してメソッドの呼び出しをひとつずつ戻っていくので、
# 例外が発生する場所が予期できない場合は、メソッド呼び出しを戻る途中にその例外を補足するコードを記述すればいい

# method_1にだけ例外処理を記述する
def method_1
  puts 'method_1 start.'
  begin
    method_2
  rescue
    puts '例外が発生しました'
  end
  puts 'method_1 end.'
end

def method_2
  puts 'method_2 staet.'
  method_3
  puts 'method_2 end.'
end

def method_3
  puts 'method_3 staet.'
  # ZeroDivisionErrorを発生させる
  1 / 0
  puts 'method_3 end.'
end

# 処理を開始する
method_1
#=> method_1 start.
#   method_2 staet.
#   method_3 staet.
#   例外が発生しました
#   method_1 end.

# method_1⇒method_2⇒method_3⇒ZeroDivisionError⇒method_2⇒method_1⇒ 例外が発生しました⇒method_1 end.

# 9.2.4

# Rubyでは発生した例外もオブジェクト
# 例外オブジェクトにメソッドを呼び出すことで例外に関する情報を取得できる

# begin
#   例外が起きうる処理
# rescue => 例外オブジェクトを格納する変数
#   例外が発生した場合の処理
# end

begin
  1 / 0
rescue => e
  puts "エラークラス：　#{e.class}"
  puts "エラーメッセージ：　#{e.message}"
  puts "バックトレース　-----"
  puts e.backtrace
  puts "-----"
end

#=> エラークラス：　ZeroDivisionError
#   エラーメッセージ：　divided by 0
#   バックトレース　-----
#   9.2.rb:83:in `/'
#   9.2.rb:83:in `<main>'
#   -----

# 9.2.5

# 例外オブジェクトのクラスが一致した場合のみ例外を補足する
# begin
#   例外が起きうる処理
# rescue 補足したい例外クラス
#   例外が発生した場合の処理
# end

begin
  1 / 0
rescue ZeroDivisionError
  puts "0で除算しました"
end
#=> 0で除算しました

# rescue節を複数書くことで異なる例外クラスに対応する
begin
  'abc'.foo
rescue ZeroDivisionError
  puts "0で除算しました"
rescue NoMethodError
  puts "存在しないメソッドが呼び出されました"
end
#=> 存在しないメソッドが呼び出されました

# ひとつのrescue節に複数の例外クラスを指定する
begin
  'abc'.foo
rescue ZeroDivisionError, NoMethodError
  puts "0で除算したか、存在しないメソッドが呼び出されました"
end
#=> 0で除算したか、存在しないメソッドが呼び出されました

# 例外オブジェクトを変数に格納する
begin
  'abc'.foo
rescue ZeroDivisionError, NoMethodError => e
  puts "0で除算したか、存在しないメソッドが呼び出されました"
  puts "エラー： #{e.class} #{e.message}"
end
#=> 0で除算したか、存在しないメソッドが呼び出されました
#   エラー： NoMethodError undefined method `foo' for "abc":String

# 9.2.6

# すべての例外クラスはExceptionクラスを継承していて、そのサブクラスとしてStandardErrorクラスとそれ以外がある
# StandardErrorクラスは通常のプログラムで発生する可能性の高い例外を表すクラス
# StandardErrorクラスを継承していないクラスの例外が発生した場合、通常では発生しない特殊なエラーが起こったことを表している
# rescue節で何もクラスを指定しなかった場合、StandardErrorクラスとそのサブクラスのみ補足される

# 9.2.7

# 例外処理を書く場合は例外クラスの継承関係を意識して順番に注意すること
# 最後にStandardErrorを指定すれば通常のプログラミングで発生するその他のエラーをすべて補足できる
begin
  # ZeroDivisionErrorを発生させる
  1 / 0
rescue NoMethodError
  puts "NoMethodErrorです"
rescue NameError
  puts "NameErrorです"
rescue # StandardError
  puts "その他のエラーです"
end
#=> その他のエラーです

# 9.2.8

# ネットワークエラーのような一時的なエラーは何度かやり直すことで正常に実行できる可能性がある
# そういった場合はrescue節でretry文を実行すると、begin節の最初からやり直せる
# 無限ループ防止のためにカウンタ変数を用意して回数を制限するほうがよい
retry_count = 0
begin
  puts '処理を開始します。'
  # わざと例外を発生させる
  1 / 0
rescue
  retry_count += 1
  if retry_count <= 3
    puts "retryします。(#{retry_count}回目)"
    retry
  else
    puts 'retryに失敗しました'
  end
end
#=> 処理を開始します。
#   retryします。(1回目)
#   処理を開始します。
#   retryします。(2回目)
#   処理を開始します。
#   retryします。(3回目)
#   処理を開始します。
#   retryに失敗しました