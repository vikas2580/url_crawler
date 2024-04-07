require 'rails_helper'

RSpec.describe Page, type: :model do
  describe "validations" do
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url) }
  end
end