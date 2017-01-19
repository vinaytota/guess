require 'test_helper'

class AnimalTest < ActiveSupport::TestCase
  test 'name uniqueness' do
    dog = Animal.new name: 'Some animal'
    assert dog.save

    another_dog = Animal.new name: 'Some animal'
    assert_not another_dog.save
  end
end
