class HomeController < ApplicationController
  skip_before_action :authorised
end
