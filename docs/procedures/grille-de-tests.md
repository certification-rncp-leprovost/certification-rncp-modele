# Grille de tests — le minimum par ressource

Validée le 20/11. Elle répond au référentiel (BC03, tests manuels et automatisés) : chaque test a un objectif clair, les cas d'exception sont couverts, les tests tournent dans la CI. Pour chaque ressource, on copie les gabarits ci-dessous et on remplace `Reservation` par la ressource.

**Ordre de travail (TDD)** : on écrit le test, on le voit échouer, on committe (`test: …`), puis on écrit le code qui le fait passer (`feat: …`). L'historique Git montre la démarche.

| Niveau | Fichier | Ce qu'on prouve |
|---|---|---|
| Modèle | `test/models/reservation_test.rb` | 1 cas valide, puis 1 test par règle de validation qui refuse |
| Policy | `test/policies/reservation_policy_test.rb` | pour chaque action, le rôle autorisé passe, l'autre est refusé |
| Intégration | `test/integration/reservations_test.rb` | visiteur renvoyé vers la connexion ; création valide (+1 en base) ; création invalide (422, base inchangée) ; accès croisé refusé |
| Système | `test/system/<parcours>_test.rb` | un test par parcours critique de la démo, console JavaScript sans erreur |
| API externe | `test/services/<service>_test.rb` | réponse simulée par un faux client ; erreur de l'API gérée |
| Manuel | `docs/livrables/BC03/plan-de-test.md` | cas d'usage et d'exception, résultat attendu / obtenu, bugs, re-tests |

## Modèle

```ruby
require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  test "une réservation complète est valide" do
    assert reservations(:une).valid?
  end

  test "refuse une date absente" do
    reservation = reservations(:une)
    reservation.date = nil
    assert_not reservation.valid?
    assert reservation.errors.added?(:date, :blank)
  end
end
```

## Policy (Pundit)

```ruby
require "test_helper"

class ReservationPolicyTest < ActiveSupport::TestCase
  test "le propriétaire peut modifier sa réservation" do
    assert ReservationPolicy.new(users(:alice), reservations(:de_alice)).update?
  end

  test "un autre utilisateur ne peut pas la modifier" do
    assert_not ReservationPolicy.new(users(:bob), reservations(:de_alice)).update?
  end

  test "la liste ne contient que les réservations de l'utilisateur" do
    scope = ReservationPolicy::Scope.new(users(:alice), Reservation).resolve
    assert_includes scope, reservations(:de_alice)
    assert_not_includes scope, reservations(:de_bob)
  end
end
```

## Intégration (contrôleur)

```ruby
require "test_helper"

class ReservationsTest < ActionDispatch::IntegrationTest
  test "un visiteur est renvoyé vers la connexion" do
    get reservations_path
    assert_redirected_to new_user_session_path
  end

  test "une création valide ajoute une réservation" do
    sign_in users(:alice)
    assert_difference("Reservation.count", 1) do
      post reservations_path, params: { reservation: { date: Date.current + 1 } }
    end
    assert_redirected_to reservation_path(Reservation.last)
  end

  test "une création invalide ne crée rien" do
    sign_in users(:alice)
    assert_no_difference("Reservation.count") do
      post reservations_path, params: { reservation: { date: nil } }
    end
    assert_response :unprocessable_content
  end

  test "accès croisé : un autre utilisateur ne peut pas modifier" do
    sign_in users(:bob)
    patch reservation_path(reservations(:de_alice)), params: { reservation: { date: Date.current + 2 } }
    assert_redirected_to root_path
    assert_equal I18n.t("pundit.not_authorized"), flash[:alert]
  end
end
```

## Système (parcours critique)

```ruby
require "application_system_test_case"

class ParcoursReservationTest < ApplicationSystemTestCase
  test "un utilisateur réserve depuis l'accueil" do
    sign_in users(:alice)
    visit root_path
    click_on I18n.t("reservations.index.new")
    assert_current_path new_reservation_path

    fill_in "reservation_date", with: Date.current + 1
    click_button I18n.t("helpers.submit.create", model: Reservation.model_name.human)

    assert_text I18n.t("reservations.create.success")
    assert_no_browser_errors
  end
end
```
`sign_in` fonctionne aussi en test système (`Devise::Test::IntegrationHelpers` est inclus dans `ApplicationSystemTestCase`).

## API externe (IA) : un faux client, sans gem de plus

Le service reçoit son client en paramètre ; le test lui passe un objet qui répond comme l'API, sans appel réseau.

```ruby
# app/services/resumeur.rb
class Resumeur
  def initialize(client: ClientIa.new)
    @client = client
  end

  def resumer(texte)
    @client.completer("Résume en une phrase : #{texte}")
  rescue ClientIa::Erreur => e
    Rails.logger.warn("API IA indisponible : #{e.class}")
    nil
  end
end

# test/services/resumeur_test.rb
class ResumeurTest < ActiveSupport::TestCase
  FauxClient = Struct.new(:reponse) do
    def completer(_prompt) = reponse
  end

  ClientEnPanne = Class.new do
    def completer(_prompt) = raise(ClientIa::Erreur)
  end

  test "renvoie la réponse du modèle" do
    assert_equal "Un résumé.", Resumeur.new(client: FauxClient.new("Un résumé.")).resumer("Long texte")
  end

  test "renvoie nil si l'API est en panne" do
    assert_nil Resumeur.new(client: ClientEnPanne.new).resumer("Long texte")
  end
end
```

## Avant de dire « terminé »
- `bin/ci` vert en local, puis CI verte sur la PR.
- `bin/recette <étape> "<description>"` après le commit : la ligne du journal fait preuve.
