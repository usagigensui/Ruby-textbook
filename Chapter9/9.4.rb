# 9.4.2

# rescueは安易に使うべきでなく、通常はフレームワークの共通処理にゆだねるべきだが、
# 例えば100人にメールを一斉送信したが、1人のメールアドレスが無効だった時など、
# 残りの99人に迷惑がかかるようなケースでは、例外をrescueして処理を最後まで続行する、といったケースもある

# 大量のユーザーにメールを送信する(例外が起きても最後まで実行する)
users.each do |user|
  begin
    # メール送信を実行
    send_mail_to(user)
  rescue => e
    # 例外のクラス名、エラーメッセージ、バックトレースをターミナルに入力
    # (ログファイルがあればそこに出力するほうがベター)
    puts "#{e.class}: #{e.message}"
    puts e.backtrace
  end
end

# 9.4.3

# 例外処理の対象範囲と対象クラスは極力絞り込むこと
require 'date'

# 平成の日付文字列をDateオブジェクトに変更する
def convert_heisei_to_date(heisei_text)
  m = heisei_text.match(/平成(?<jp_year>\d+)年(?<month>\d+)月(?<day>\d+)日/)
  year = m[:jp_year].to_i + 1988
  month = m[:month].to_i
  day = m[:day].to_i
  #  例外処理の範囲は必要最低限にし、補足する例外クラスを限定する
  begin
    Date.new(year, month, day)
  rescue ArgumentError
    # 無効な日付であればnilを返す
    nil
  end
end

convert_heisei_to_date('平成28年12月31日') #=> "2016-12-31"
convert_heisei_to_date('平成28年99月99日') #=> nil

# 9.4.4

# 例外の発生がある程度予測できる処理であれば、実行前に分岐でエラーを回避するほうがよい
# Date.valid_date?は日付が有効か確認するメソッド
require 'date'

def convert_heisei_to_date(heisei_text)
  m = heisei_text.match(/平成(?<jp_year>\d+)年(?<month>\d+)月(?<day>\d+)日/)
  year = m[:jp_year].to_i + 1988
  month = m[:month].to_i
  day = m[:day].to_i
  # 正しい日付の場合のみDateオブジェクトを作成する
  if Date.valid_date?(year, month, day)
    Date.new(year, month, day)
  end
end

convert_heisei_to_date('平成28年12月31日') #=> "2016-12-31"
convert_heisei_to_date('平成28年99月99日') #=> nil

# 9.4.5

# case文で条件分岐を作る場合、予期しない想定外のパターンは、else節で例外を発生させるのがよい

def currency_of(country)
  case country
  when :japan
    'yen'
  when :us
    'dollar'
  when :india
    'rupee'
  else
    raise ArgumentError, "無効な国名です。#{country}"
  end
end
# 例外が発生する
puts currency_of(:italy) #=> 無効な国名です。italy (ArgumentError)