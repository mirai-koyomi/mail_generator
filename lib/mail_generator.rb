require "mail_generator/version"
require "mail_generator/backlog"
require "mail_generator/Util"

module MailGenerator
	def apc_generate(ticket, branch, reserved, apply_date, release_date)
	end
end
	
	secret = MailGenerator::Util.load_secret_file
	client = MailGenerator::Backlog::API.new(secret['space_id'], secret['api_key'], secret['project_key'])
	git = MailGenerator::Git.new()
