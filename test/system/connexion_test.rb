require "application_system_test_case"

# Parcours critique : un visiteur se connecte depuis la page d'accueil.
class ConnexionTest < ApplicationSystemTestCase
  test "un visiteur se connecte depuis la page d'accueil" do
    visit root_path
    click_on "Se connecter"

    fill_in "Email", with: "alice@example.com"
    fill_in "Mot de passe", with: "motdepasse123"
    click_button "Se connecter" # le bouton du formulaire, pas le lien du menu

    assert_text "alice@example.com"
  end
end
