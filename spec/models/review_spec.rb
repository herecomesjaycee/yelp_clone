require 'rails_helper'

describe Review, type: :model do
  it "is invalid if the rating is more than 5" do
	review = Review.new(rating: 10, user_id: 1, restaurant_id: 1)
   expect(review).to have(1).error_on(:rating)
  end

  it "is invalid if user made another review" do
  	before = Review.new(rating: 3, user_id: 1, restaurant_id: 1 )
  	review = Review.new(rating: 2, user_id: 1, restaurant_id: 1)
  	expect(review).to have(1).error_on(:user)
  end

end
