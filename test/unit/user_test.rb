require 'test_helper'

class UserTest < ActiveSupport::TestCase

  #should have_many(:statuses)
  #should have_many(:user_friendships)
  #should have_many(:friends)

	test "a user should enter a first name"  do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end

	test "a user should enter a last name"  do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

#	test "a user should enter a profile name"  do
#		user = User.new
#		assert !user.save
#		assert !user.errors[:profile_name].empty?
#	end

	test "a user should enter an email address"  do
		user = User.new
		assert !user.save
		assert !user.errors[:email].empty?
	end

	test "a user should enter a unique profile"  do
		user = User.new
		user.profile_name = users(:jon).profile_name
		assert !user.save
		#puts user.errors.inspect
		assert !user.errors[:profile_name].empty?
	end

	test "a profile name should not contain spaces" do
		user = User.new(first_name: "Jon", last_name: "Gjerset", email: "jon2@gjerset.com")
		user.password = user.password_confirmation = 'password'

		user.profile_name = "Name with spaces"

		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("Profile name must not contain spaces")
	end

    test "a properly formated profile name should pass" do
		user = User.new(first_name: "Jon", last_name: "Gjerset", email: "jon2@gjerset.com")
		user.password = user.password_confirmation = 'password'
        user.profile_name = 'jgjerset112'
		assert user.valid?
	end

    test "that no error is raises when trying to access a friend list" do
    	assert_nothing_raised do
    		users(:jon).friends
    	end
    end	

    test "that creating friendships on a user works" do
    	users(:jon).friends << users(:bill)
    	users(:jon).friends.reload
    	assert users(:jon).friends.include?(users(:bill))
    	
    end	

    test "that creating friendships on a user id works" do
    	UserFriendship.create user_id: users(:jon).id, friend_id: users(:bill).id
        assert users(:jon).friends.include?(users(:bill))
    end	

    test "that calling to_param on a user opens up the profile" do
        assert_equal "jgjerset", users(:jon).to_param
    end
end