module MailGenerator
	class Git
		# BacklogへのAPI接続を直接行う。
		# @attr_reader client [Object] BacklogのAPIオブジェクト。gem化した際に外部から情報を柔軟に引き出せるよう、念のため読取だけ可能にしておく。
		def initialize(repo_path)
			@repo = repository(repo_path)
		end
	end
end
