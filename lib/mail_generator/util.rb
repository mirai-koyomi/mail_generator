require 'json'

module MailGenerator
	# 汎用的な機能をまとめたクラス。
	# 今後煩雑化してきた場合はモジュール化してクラスを切り分ける。
	class Util
		# secret.jsonファイルを読み込む
		# @return [Hash] 連想配列化されたsecret.json
		def self.load_secret_file
			File.open('secret.json') do |file|
				JSON.load(file)
			end
		end
	end
end
