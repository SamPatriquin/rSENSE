require 'base64'

class UserMailer < ActionMailer::Base
  helper ActionView::Helpers::UrlHelper

  def validation_email(user)
    @user = user
    @url  = url_for(controller: 'users', action: 'validate', key: @user.validation_key, only_path: false)

    hostname = `hostname`.chomp
    from = "no-reply@#{hostname}"

    mail(from: from, to: user.email, subject: "Please verify your iSENSE account's email.")
  end

  def pw_reset_email(user)
    user.send_reset_password_instructions
  end

  def report_content_email(params)
    from = 'isenseproject@gmail.com'

    @prev_url = params[:prev_url]
    @current_user_id = params[:current_user]
    @content = params[:content]

    mail(from: from, to: from, Cc: ENV['FRED_EMAIL'], subject: 'Report of inappropriate content on iSense.')
  end
end
