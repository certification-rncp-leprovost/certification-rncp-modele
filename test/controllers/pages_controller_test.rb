require "test_helper"

# La page d'accueil est publique : un visiteur non connecté la voit.
class PagesControllerTest < ActionDispatch::IntegrationTest
  test "un visiteur voit la page d'accueil sans se connecter" do
    get root_path
    assert_response :success
    assert_dom "h1", "Accueil"
  end

  test "le menu propose la connexion au visiteur" do
    get root_path
    assert_dom "a", "Se connecter"
  end
end
