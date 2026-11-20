# Contrôleur parent de toute l'application.
# Choix de sécurité par défaut (décision 0003) : tout est fermé, on ouvre au cas par cas.
class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Navigateurs récents seulement (règle par défaut de Rails 8).
  allow_browser versions: :modern

  # 1. Identité : il faut être connecté, sauf exception déclarée (Devise).
  before_action :authenticate_user!

  # 2. Droits : chaque action doit appeler `authorize` (ou `policy_scope` pour une liste).
  #    Si on l'oublie, Pundit lève une erreur en test : l'oubli ne passe pas inaperçu.
  after_action :verify_authorized, unless: :skip_pundit?
  after_action :verify_policy_scoped, if: -> { action_name == "index" && !skip_pundit? }

  # 3. Refus d'accès : message clair et retour à la page précédente, pas d'erreur 500.
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  # Devise et les pages publiques n'ont pas de policy.
  def skip_pundit?
    devise_controller? || controller_name == "pages"
  end

  def user_not_authorized
    redirect_back_or_to root_path, alert: t("pundit.not_authorized")
  end
end
