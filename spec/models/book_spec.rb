require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'Validations' do
    context 'Success' do
      it 'should be a valid book with entries from FactoryGirl' do
        FactoryGirl.build(:book).should be_valid
      end
      it 'should be a valid book with manual entries' do
        FactoryGirl.build(:book, name:"Memories of midnight", author:"Sydney Sheldon").should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid book with nil name' do
        FactoryGirl.build(:book, name:nil).should_not be_valid
      end
    end
  end

  context 'Associations' do
    context 'Success' do
      it 'should belongs to library' do
        library = FactoryGirl.create(:library, phone_no:"3344556677")
        book = FactoryGirl.create(:book, library_id:library.id)
        book.library.id.should eq library.id
      end
      it 'should belongs to category' do
        category = FactoryGirl.create(:category)
        book = FactoryGirl.create(:book, category_id:category.id)
        book.category.id.should eq category.id
      end
      it 'should belongs to member' do
        member = FactoryGirl.create(:member, phone_no:"3344556677")
        book = FactoryGirl.create(:book, member_id:member.id)
        book.member.id.should eq member.id
      end
      it 'should have many issue_histories' do
        book = FactoryGirl.create(:book)
        issue_history1 = FactoryGirl.create(:issue_history, book_ids:book.id)
        issue_history2 = FactoryGirl.create(:issue_history, book_ids:book.id)
        book.issue_histories.should include issue_history1
        book.issue_histories.should include issue_history2 
      end
    end

    context 'Failure' do
      it 'should not belongs to library' do
        library1 = FactoryGirl.create(:library, phone_no:"3344556677")
        library2 = FactoryGirl.create(:library, phone_no:"3344556677")
        book1 = FactoryGirl.create(:book, library_id:library1.id)
        book2 = FactoryGirl.create(:book, library_id:library2.id)
        book1.library.id.should eq library1.id
        book1.library.id.should_not eq library2.id
        book2.library.id.should eq library2.id
        book2.library.id.should_not eq library1.id
      end
      it 'should not belongs to category' do
        category1 = FactoryGirl.create(:category)
        category2 = FactoryGirl.create(:category)
        book1 = FactoryGirl.create(:book, category_id:category1.id)
        book2 = FactoryGirl.create(:book, category_id:category2.id)
        book1.category.id.should eq category1.id
        book1.category.id.should_not eq category2.id
        book2.category.id.should eq category2.id
        book2.category.id.should_not eq category1.id
      end
      it 'should not belongs to member' do
        member1 = FactoryGirl.create(:member, phone_no:"3344556677")
        member2 = FactoryGirl.create(:member, phone_no:"3344556677")
        book1 = FactoryGirl.create(:book, member_id:member1.id)
        book2 = FactoryGirl.create(:book, member_id:member2.id)
        book1.member.id.should eq member1.id
        book1.member.id.should_not eq member2.id
        book2.member.id.should eq member2.id
        book2.member.id.should_not eq member1.id
      end
      it 'should not have issue_histories as a single object of book' do
        book = FactoryGirl.create(:book)
        expect { book.issue_history }.to raise_exception
        expect { book.issue_histories }.to_not raise_exception 
      end
    end
  end
end