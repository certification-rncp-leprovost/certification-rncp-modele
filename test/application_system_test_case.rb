require "test_helper"

# Tests système : un vrai navigateur (Chrome sans écran) joue les parcours de bout en bout.
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1000 ] do |options|
    # Indispensable dans les conteneurs (CI, WSL) : Chrome n'y dispose ni du bac à sable ni de /dev/shm.
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
  end
end
