require 'rails_helper'

RSpec.describe List, type: :model do

  context "associations :" do

    before(:all) do
      @user = FactoryBot.create(:user)
      @list = FactoryBot.create(:list, user_id: @user.id)
    end

    it "belongs to a user" do
      expect(@list.user).to eq @user
    end

    it "has many items" do
      items = FactoryBot.create_list(:item, 5)
      @list.items << items
      expect(@list.items).to eq items
    end

    it "has many comments" do
      comments = FactoryBot.create_list(:comment, 3)
      @list.comments << comments
      expect(@list.comments).to eq comments
    end

  end

  context "scopes :" do

    before(:all) do
      pub = FactoryBot.create(:list)
      unpub = FactoryBot.create(:list, :unpublished)
      lists = [pub.id, unpub.id]
      @lists = List.where(id: lists)
    end

    it "published" do
      expect(@lists.size).to eq 2
      expect(@lists.published.size).to eq 1
    end

  end

end
