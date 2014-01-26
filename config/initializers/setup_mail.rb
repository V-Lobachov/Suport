ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "localhost:3000"
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => "587",
  :domain               => 'localhost',
  :user_name            => 'SuportApp1@gmail.com',
  :password             => 'app12/*qw-+',
  :authentication       => 'plain',
  :enable_starttls_auto => true  }



