require "rails_helper"

RSpec.describe Restaurant, type: :model do
  it { should belong_to(:user) }
end

