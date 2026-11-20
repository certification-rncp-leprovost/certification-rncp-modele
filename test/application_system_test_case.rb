require "test_helper"

# Tests système : un vrai navigateur (Chrome sans écran) joue les parcours de bout en bout.
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1000 ] do |options|
    # Indispensable dans les conteneurs (CI, WSL) : Chrome n'y dispose ni du bac à sable ni de /dev/shm.
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    # Garder la console du navigateur pour y chercher les erreurs JavaScript.
    options.add_option("goog:loggingPrefs", { browser: "ALL" })
  end

  # Filet n° 1 : une exception serveur fait échouer le test, au lieu d'une page d'erreur
  # que Turbo masquerait. Réglage limité aux tests système (les tests d'intégration
  # peuvent vérifier une réponse 404).
  setup do
    @show_exceptions = Rails.application.env_config["action_dispatch.show_exceptions"]
    Rails.application.env_config["action_dispatch.show_exceptions"] = :none
  end

  teardown do
    Rails.application.env_config["action_dispatch.show_exceptions"] = @show_exceptions
  end

  # Filet n° 2 : aucune erreur dans la console JavaScript du navigateur.
  def assert_no_browser_errors
    errors = page.driver.browser.logs.get(:browser).select { |entry| entry.level == "SEVERE" }
    assert_empty errors.map(&:message), "erreurs dans la console du navigateur"
  end
end
