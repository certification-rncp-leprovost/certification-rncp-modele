# Pages publiques, sans connexion ni policy.
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end
end
