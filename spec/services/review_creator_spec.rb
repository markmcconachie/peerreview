require 'spec_helper'

describe ReviewCreator do
  let (:review_params) { FactoryGirl.attributes_for(:review) }
  let (:review_creator) { ReviewCreator.new().call }

  describe "#call" do
  end
end
