require 'rails_helper'

RSpec.describe List, type: :model do

  context "validations :" do

    let(:list) { FactoryGirl.create(:list) }

    it "list is valid" do
      expect(list).to be_valid
    end

    it "has many items" do
      items = FactoryGirl.create_list(:item, 5, list: list)
      expect(list.items.size).to eq 5
    end

    it "has many comments" do
      items = FactoryGirl.create_list(:comment, 3, list: list)
      expect(list.comments.size).to eq 3
    end

  end

  context "scopes :" do

    before(:all) do
      pub = FactoryGirl.create(:list)
      unpub = FactoryGirl.create(:list, :unpublished)
      lists = [pub.id, unpub.id]
      @lists = List.where(id: lists)
    end

    it "published" do
      expect(@lists.size).to eq 2
      expect(@lists.published.size).to eq 1
    end

  end

end
