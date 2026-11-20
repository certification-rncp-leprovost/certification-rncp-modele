require "test_helper"

# Modèle User (Devise) : exemple de tests unitaires, un objectif par test.
class UserTest < ActiveSupport::TestCase
  test "un utilisateur avec e-mail et mot de passe est valide" do
    user = User.new(email: "nouveau@example.com", password: "motdepasse123")
    assert user.valid?
  end

  test "refuse un e-mail absent" do
    user = User.new(email: "", password: "motdepasse123")
    assert_not user.valid?
    assert user.errors.added?(:email, :blank)
  end

  test "refuse un e-mail déjà utilisé" do
    user = User.new(email: users(:alice).email, password: "motdepasse123")
    assert_not user.valid?
    assert user.errors.added?(:email, :taken, value: users(:alice).email)
  end

  test "refuse un mot de passe trop court" do
    user = User.new(email: "court@example.com", password: "12345")
    assert_not user.valid?
    assert user.errors.include?(:password)
  end
end
