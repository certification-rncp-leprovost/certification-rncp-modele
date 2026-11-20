require "test_helper"

# Inscription : modèle de test « création valide / création refusée ».
class InscriptionTest < ActionDispatch::IntegrationTest
  test "une inscription valide crée un compte et connecte l'utilisateur" do
    assert_difference("User.count", 1) do
      post user_registration_path, params: { user: { email: "nouveau@example.com", password: "motdepasse123", password_confirmation: "motdepasse123" } }
    end
    assert_redirected_to root_path
  end

  test "une inscription invalide ne crée rien et réaffiche le formulaire" do
    assert_no_difference("User.count") do
      post user_registration_path, params: { user: { email: "", password: "court", password_confirmation: "autre" } }
    end
    assert_response :unprocessable_content
  end
end
