require "test_helper"

# Le parcours de connexion fonctionne de bout en bout (Devise).
class AuthentificationTest < ActionDispatch::IntegrationTest
  test "un utilisateur se connecte avec son e-mail et son mot de passe" do
    post user_session_path, params: { user: { email: "alice@example.com", password: "motdepasse123" } }
    assert_redirected_to root_path
    follow_redirect!
    assert_dom "span.nav-link", "alice@example.com"
  end

  test "un mauvais mot de passe est refusé" do
    post user_session_path, params: { user: { email: "alice@example.com", password: "faux" } }
    assert_response :unprocessable_content
  end

  test "un utilisateur connecté voit son e-mail dans le menu" do
    sign_in users(:alice)
    get root_path
    assert_dom "span.nav-link", "alice@example.com"
  end
end
