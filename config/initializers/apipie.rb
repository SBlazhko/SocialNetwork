Apipie.configure do |config|
  config.app_name                = "SocialNetwork"


  config.api_base_url            = "/api/v1/"
  config.doc_base_url            = "apipie"
  config.validate 				 = false

  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
