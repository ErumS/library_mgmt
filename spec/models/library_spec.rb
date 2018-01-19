require 'rails_helper'

RSpec.describe Library, type: :model do
  context 'Validations' do
    context 'Success' do
      it 'should be a valid library with entries from FactoryGirl' do
        FactoryGirl.build(:library, phone_no:"5655748754").should be_valid
      end
      it 'should be a valid library with manual entries' do
        FactoryGirl.build(:library, name:"High school", address:"UK", phone_no:"5655748754").should be_valid
      end
      it 'should be a valid library with manual entries' do
        FactoryGirl.build(:library, name:"High school", phone_no:"5655748754").should be_valid
      end
      it 'should be a valid library with manual entries' do
        FactoryGirl.build(:library, address:"UK", phone_no:"5655748754").should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid library with nil name' do
        FactoryGirl.build(:library, name:nil).should_not be_valid
      end
      it 'should not be a valid library with nil address' do
        FactoryGirl.build(:library, address:nil).should_not be_valid
      end
      it 'should not be a valid library with nil phone_no' do
        FactoryGirl.build(:library, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid library with nil name and address' do
        FactoryGirl.build(:library, name:nil, address:nil).should_not be_valid
      end
      it 'should not be a valid library with nil name and phone_no' do
        FactoryGirl.build(:library, name:nil, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid library with nil address and phone_no' do
        FactoryGirl.build(:library, address:nil, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid library with nil name, address and phone_no' do
        FactoryGirl.build(:library, name:nil, address:nil, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid library with invalid phone_no of length less than 8' do
        FactoryGirl.build(:library, phone_no:"1234").should_not be_valid
      end
      it 'should not be a valid library with invalid phone_no of length greater than 15' do
        FactoryGirl.build(:library, phone_no:"6732723886472354654535462374628724").should_not be_valid
      end
    end
  end

  context 'Associations' do
    context 'Success' do
      it 'should have many books' do
        library = FactoryGirl.create(:library, phone_no:"467574378")
        book1 = FactoryGirl.create(:book, library_id:library.id)
        book2 = FactoryGirl.create(:book, library_id:library.id)
        library.books.should include book1
        library.books.should include book2 
      end
      it 'should have many members' do
        library = FactoryGirl.create(:library, phone_no:"467574378")
        member1 = FactoryGirl.create(:member, library_id:library.id)
        member2 = FactoryGirl.create(:member, library_id:library.id)
        library.members.should include member1
        library.members.should include member2 
      end
      it 'should have many categories' do
        library = FactoryGirl.create(:library, phone_no:"467574378")
        category1 = FactoryGirl.create(:category, library_id:library.id)
        category2 = FactoryGirl.create(:category, library_id:library.id)
        library.categories.should include category1
        library.categories.should include category2 
      end
    end

    context 'Failure' do
      it 'should not have books as a single object of library' do
        library = FactoryGirl.create(:library, phone_no:"467574378")
        expect { library.book }.to raise_exception
        expect { library.books }.to_not raise_exception 
      end
      it 'should not have members as a single object of library' do
        library = FactoryGirl.create(:library, phone_no:"467574378")
        expect { library.member }.to raise_exception
        expect { library.members }.to_not raise_exception 
      end
      it 'should not have categories as a single object of library' do
        library = FactoryGirl.create(:library, phone_no:"467574378")
        expect { library.category }.to raise_exception
        expect { library.categories }.to_not raise_exception 
      end
    end
  end
end