class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :home

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
