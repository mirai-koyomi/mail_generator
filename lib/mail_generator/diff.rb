module MailGenerator
	# ファイル抽出を行うためのファイルの一覧を管理する。
	# @attr_reader result [Array] ブランチ上で追加、編集、複製、名称変更が行われたファイルの一覧。
	# @todo develop層がない場合などの処理の振り分け実装
	class Diff
		attr_reader :result
		# 対象プロジェクトのフォルダパスとブランチ名を元に差分ファイルを取得する。
		# @param branch [String] 差分を抽出したい対象ブランチの名前。
		# @param dir_path [String] ファイル差分抽出となるプロジェクトのリポジトリが設置されている場所へのパス。
		def initialize(branch, dir_path)
			@dir_path = dir_path
			@result = compare_develop(branch)
		end
		
		private
		# featureブランチ上で変更が加えられたファイルのリストを取得する。
		# @param branch [String] 対象となるfeatureブランチの名前
		# @return [Array] 編集が加えられたファイルのリスト。削除は除外している。
		def compare_develop(branch)
			file_ary = []
			hash = start_point_hash branch
			file_list = `cd #{@dir_path} && git checkout #{branch} && git pull origin && git diff --name-only --diff-filter=MACR #{hash} HEAD`

			file_list.each_line do |file_name|
				file_ary << file_name.chomp
			end
			
			return file_ary
		end
		
		# そのブランチが分岐したポイントをhash値で返す。
		# @param branch [String] 分岐点を調べたいブランチ名
		# @return [String] ブランチが分岐したコミットのハッシュ値
		def start_point_hash(branch)
			commit_info = `cd #{@dir_path} && git fetch origin && git show-branch --sha1-name origin/develop origin/#{branch} | tail -1`
			return commit_info.match(/\[(?<hash>[\d\w]*)\]/)[:hash]
		end
	end
end