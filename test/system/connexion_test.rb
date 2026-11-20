require "application_system_test_case"

# Parcours critique : un visiteur se connecte depuis la page d'accueil.
class ConnexionTest < ApplicationSystemTestCase
  test "un visiteur se connecte depuis la page d'accueil" do
    visit root_path
    click_on I18n.t("app.sign_in")
    assert_current_path new_user_session_path

    fill_in "user_email", with: "alice@example.com"
    fill_in "user_password", with: "motdepasse123"
    click_button I18n.t("devise.sessions.new.sign_in")

    assert_current_path root_path
    assert_text "alice@example.com"
    assert_no_browser_errors
  end
end
