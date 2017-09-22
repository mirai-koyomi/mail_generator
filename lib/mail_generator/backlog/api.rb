require 'backlog_kit'

module MailGenerator
	# BacklogからAPI経由で情報を取得する。
	# メール文面に必要な情報を引き出すだけなので、基本Backlogを更新するなどはしていない。
	module Backlog
		# BacklogへのAPI接続を直接行う。
		# @attr_reader client [Object] BacklogのAPIオブジェクト。gem化した際に外部から情報を柔軟に引き出せるよう、念のため読取だけ可能にしておく。
		class API
			attr_reader :client

			# プロジェクトごとにインスタンスを生成する。
			# @param space_id [String] BacklogのスペースID
			# @param api_key [String] Backlog API Key
			# @param project_key [String] 対象となるプロジェクト
			def initialize(space_id, api_key, project_key)
				@client = connection(space_id, api_key)
				@project_id = get_project_id(project_key)
			end
			
			# 対象の課題の名前を取得する
			# @param issue_key [String] 対象となる課題の固有キー
			# @return [String] 課題名称
			def issue_name(issue_key)
				name = @client.get_issue(issue_key).body.summary
				return name.match(/(ă.*ă)*(\[.*\])*(?<name>.*)/)[:name]
			end
			
			def issue_env(issue_key)
				env_name = @client.get_issue(issue_key).body.issue_type.name
				env = ''
				
				case env_name
				when 'はたらいく【HAT】'
					env = 'HAT'
				when 'とらばーゆ【TRN】'
					env = 'TRN'
				end
			end
			
			private
			# BacklogのAPIに接続する
			# @param space_id [String] BacklogのスペースID
			# @param api_key [String] Backlog API Key
			# @return [Object] BacklogのAPIオブジェクト
			def connection(space_id, api_key)
				return BacklogKit::Client.new(space_id: space_id, api_key: api_key)
			end
			
			# プロジェクトのIDを取得する
			# @param project_key [String] 対象となるプロジェクト
			# @return [Integer] プロジェクトのID
			def get_project_id(project_key)
				project = @client.get_projects.body.find do |pb|
					pb.projectKey == project_key
				end
				
				return project.id
			end
		end
	end
end
