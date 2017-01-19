require 'test_helper'

class GuessControllerTest < ActionDispatch::IntegrationTest
  test 'get make_guess should return 200' do
    get make_guess_url
    assert_response :success
  end

  test 'post make_guess should create favorite animal' do
    # using webmock to prevent external service call
    stub_request(
      :get, Rails.configuration.external_services['animal_guess_uri']
    ).with(
      query: { height: 66, weight: 145 }
    ).to_return(
      body: "{\"favorite_animal_guess_id\": #{Animal.first.id}}",
      headers: { 'Content-Type' => 'application/json' }
    )

    post make_guess_url params: { height_ft: 5, height_in: 6, weight_lb: 145 }
    assert_response :redirect
    assert_redirected_to confirm_guess_url(FavoriteAnimal.last)

    assert_equal FavoriteAnimal.last.height, 66
    assert_equal FavoriteAnimal.last.weight, 145
    assert_equal FavoriteAnimal.last.animal_guess, Animal.first
    assert_nil FavoriteAnimal.last.animal
  end

  test 'get confirm_guess should show confirmation' do
    fake_guess = favorite_animals :fake_guess
    get confirm_guess_url fake_guess

    assert_response :success
    # confirm button should have guess id recorded on fake guess
    assert_select ".confirmGuess[value=\"#{fake_guess.animal_guess.id}\"]", 1
    # other button should have other animal id
    assert_select ".correctGuess[value=\"#{animals(:one).id}\"]", 1
  end

  test 'post confirm_guess should record actual value' do
    fake_guess = favorite_animals :other_fake_guess
    post confirm_guess_url fake_guess, params: { animal_id: animals(:two).id }
    assert_response :success
    assert_equal FavoriteAnimal.find(fake_guess.id).animal, animals(:two)
  end

  test 'get confirm_guess does not let you change answer' do
    get confirm_guess_url favorite_animals(:completed_guess)
    assert_response :redirect
  end

  test 'post confirm_guess does not let you change answer' do
    completed_guess = favorite_animals :completed_guess
    post confirm_guess_url completed_guess, params: { animal_id: animals(:one).id }
    assert_response :error
    assert_equal FavoriteAnimal.find(completed_guess.id).animal, animals(:two)
  end
end
