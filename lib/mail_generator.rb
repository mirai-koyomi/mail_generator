require "mail_generator/version"
require "mail_generator/user"
require "mail_generator/backlog"
require "mail_generator/diff"
require "mail_generator/mail"
require "mail_generator/util"

module MailGenerator
  user = User.new
	client = Backlog::API.new(user.space_id, user.api_key, user.project_key)
	diff = Diff.new('feature/CW_DEGIN_TASK-13483_atarimae', user.project_dir)


  def apc_generate(ticket, branch, reserved, apply_date, release_date)
  end
end

	secret = MailGenerator::Util.load_secret_file
	client = MailGenerator::Backlog::API.new(secret['space_id'], secret['api_key'], secret['project_key'])

	p diff.result