require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'Validations' do
    context 'Success' do
      it 'should be a valid category with entries from FactoryGirl' do
        FactoryGirl.build(:category).should be_valid
      end
      it 'should be a valid category with manual entries' do
        FactoryGirl.build(:category, department:"Fiction").should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid category with nil department' do
        FactoryGirl.build(:category, department:nil).should_not be_valid
      end
    end
  end

  context 'Associations' do
    context 'Success' do
      it 'should belongs to library' do
        library = FactoryGirl.create(:library, phone_no:"3344556677")
        category = FactoryGirl.create(:category, library_id:library.id)
        category.library.id.should eq library.id
      end
      it 'should have many books' do
        category = FactoryGirl.create(:category)
        book1 = FactoryGirl.create(:book, category_id:category.id)
        book2 = FactoryGirl.create(:book, category_id:category.id)
        category.books.should include book1
        category.books.should include book2 
      end
    end

    context 'Failure' do
      it 'should not belongs to library' do
        library1 = FactoryGirl.create(:library, phone_no:"3344556677")
        library2 = FactoryGirl.create(:library, phone_no:"3344556677")
        category1 = FactoryGirl.create(:category, library_id:library1.id)
        category2 = FactoryGirl.create(:category, library_id:library2.id)
        category1.library.id.should eq library1.id
        category1.library.id.should_not eq library2.id
        category2.library.id.should eq library2.id
        category2.library.id.should_not eq library1.id
      end
      it 'should not have books as a single object of category' do
        category = FactoryGirl.create(:category)
        expect { category.book }.to raise_exception
        expect { category.books }.to_not raise_exception 
      end
    end
  end
end