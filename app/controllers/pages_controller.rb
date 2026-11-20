# Pages publiques, sans connexion ni policy.
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home # controles: ok page publique d accueil, hors ressource (décision 0003)
  end
end
