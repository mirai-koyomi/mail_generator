require "mail_generator/util"

module MailGenerator
  class User
    attr_reader :name, :api_key, :space_id, :project_key, :project_dir

    def initialize()
      json = MailGenerator::Util.load_secret_file

      @name = json.user_name
      @api_key = json.api_key
      @space_id = json.space_id
      @project_key = json.project_key
      @project_dir = json.project_dir
    end
  end
end