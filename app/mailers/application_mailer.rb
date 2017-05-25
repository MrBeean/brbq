class ApplicationMailer < ActionMailer::Base
  default from: ENV['action_mailer_user']
  layout 'mailer'
end
