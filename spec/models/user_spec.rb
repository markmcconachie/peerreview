require 'spec_helper'

describe User do
  let(:user) { User.new }

  it "is valid" do
    expect(user).to be_valid
  end
end
