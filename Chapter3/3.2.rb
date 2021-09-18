# Minitestはテスト用のフレームワーク
# Rubyと同時にインストールされるのでセットアップ不要
# もしインストールされていなければ下記コードを入力すること
# gem install minitest -v 5.10.1

# 3.2.1

# テストコードの基本形

# テストコードファイルの名前はスネークケースで書く
require 'minitest/autorun'　# Minitestの読込み

class SampleTsst < Minitest::Test # クラス名はキャメルケースで書く # Minitest::Testを継承
  def test_sample # test_から始まるメソッド名にすること
    assert_equal 'RUBY', 'ruby'.upcase
  end
end

# assert_equalは実行結果を確認するための検証メソッド
# assert_equal 期待する結果, テスト対象となる値や式

# 3.2.2

# aがbと等しければパス
assert_equal b, assert_equal

# aが真であればパス
assert a

# aが偽であればパス
refute a

# 3.2.3

# 実行結果のfailuresとerrorsの件数がどちらもゼロであればテストはパスしたことになる
# failures:検証に失敗したメソッド
# errors:検証中にエラーが発生したメソッド

# 3.2.4

# テストが失敗した場合、失敗(Failure)が表示され、詳細を確認することができる
# Expected:期待した結果
# Actual:実際の結果

# 3.2.5

# 検証中にエラーが起きた場合はエラー(Error)が表示され、詳細を確認できる
# エラーが起きてもテストメソッドは続けて実行される