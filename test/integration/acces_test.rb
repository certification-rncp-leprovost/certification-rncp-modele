require "test_helper"

# Sécurité fermée par défaut (décision 0003) : une page protégée renvoie le visiteur vers la connexion.
class AccesTest < ActionDispatch::IntegrationTest
  test "un visiteur est renvoyé vers la connexion sur une page protégée" do
    get edit_user_registration_path
    assert_redirected_to new_user_session_path
  end

  test "un utilisateur connecté accède à son compte" do
    sign_in users(:alice)
    get edit_user_registration_path
    assert_response :success
  end
end
