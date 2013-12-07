require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  #should belong_to(:user)
  #should belong_to(:friend)

  test "that creating a friendship works" do 
    UserFriendship.create user: users(:jon), friend: users(:bill)
    assert users(:jon).friends.include?(users(:bill))
    end
end
