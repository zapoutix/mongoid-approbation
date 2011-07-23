#encoding: utf-8
require "spec_helper"

module Mongoid
  describe Approbation do
    let!(:book) do
      Book.new
    end

    context "when the object is top-level" do
      it "generates a slug" do
        book.status.should eql :pending
      end

      it "generates a slug" do
        book.is_status(:pending).should eql true
      end

      it "generates a slug" do
        book.is_status(:accepted).should eql false
      end

    end

    context "when the object is top-level 2" do

      it "validate a slug" do
        trash = Book.create(:title => "A Thousand Val")
        trash.status.should eql :pending
        trash.set_status(:accepted)
        trash.status.should eql :accepted
        trash.save
        trash.status.should eql :accepted
      end

      it "reject a slug" do
        trash = Book.create(:title => "A Thousand Rej")
        trash.status.should eql :pending
        trash.set_status(:rejected)
        trash.status.should eql :rejected
        trash.save
        trash.status.should eql :rejected
      end

    end

    context "when the object is top-level 3" do

      it "validate a slug" do
        trash = Book.create(:title => "A Thousand Val")
        trash.status.should eql :pending
        trash.set_status(:accepted)
        trash.status.should eql :accepted
        trash.save
        trash.status.should eql :accepted
        trash.title = "salut les amis"
        trash.save
        trash.status.should eql :pending
      end

      it "validate a slug" do
        Book.destroy_all
        trash = Book.create(:title => "A Thousand Val")
        trash.save

        Book.find_by_status(:pending).length.should eql 1
        Book.find_by_status(:accepted).length.should eql 0
        Book.find_by_status(:rejected).length.should eql 0
      end

      it "validate a slug" do
        Book.destroy_all
        trash = Book.create(:title => "A Thousand Val")
        trash.set_status(:accepted)
        trash.save

        Book.find_by_status(:accepted).length.should eql 1
      end

      it "validate a slug" do
        Book.destroy_all
        trash = Book.create(:title => "A Thousand Val")
        trash.set_status(:accepted)
        trash.save
        trash.title = "lala"
        trash.save
        Book.find_by_status(:accepted).length.should eql 0
        Book.find_by_status(:pending).length.should eql 1
      end
    end
  end
end
