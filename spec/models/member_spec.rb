require 'rails_helper'

RSpec.describe Member, type: :model do
  context 'Validations' do
    context 'Success' do
      it 'should be a valid member with entries from FactoryGirl' do
        FactoryGirl.build(:member, phone_no:"5655748754").should be_valid
      end
      it 'should be a valid member with manual entries' do
        FactoryGirl.build(:member, name:"Alex", phone_no:"5655748754").should be_valid
      end
      it 'should be a valid member with manual entries' do
        FactoryGirl.build(:member, phone_no:"5655748754").should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid member with nil name' do
        FactoryGirl.build(:member, name:nil).should_not be_valid
      end
      it 'should not be a valid member with nil phone_no' do
        FactoryGirl.build(:member, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid member with nil name and phone_no' do
        FactoryGirl.build(:member, name:nil, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid member with invalid phone_no of length less than 8' do
        FactoryGirl.build(:member, phone_no:"1234").should_not be_valid
      end
      it 'should not be a valid member with invalid phone_no of length greater than 15' do
        FactoryGirl.build(:member, phone_no:"6732723886472354654535462374628724").should_not be_valid
      end
    end
  end

  context 'Associations' do
    context 'Success' do
      it 'should belongs to library' do
        library = FactoryGirl.create(:library, phone_no:"3344556677")
        member = FactoryGirl.create(:member, library_id:library.id)
        member.library.id.should eq library.id
      end
      it 'should have many books' do
        member = FactoryGirl.create(:member, phone_no:"467574378")
        book1 = FactoryGirl.create(:book, member_id:member.id)
        book2 = FactoryGirl.create(:book, member_id:member.id)
        member.books.should include book1
        member.books.should include book2 
      end
      it 'should have many issue_histories' do
        member = FactoryGirl.create(:member, phone_no:"467574378")
        issue_history1 = FactoryGirl.create(:issue_history, member_id:member.id)
        issue_history2 = FactoryGirl.create(:issue_history, member_id:member.id)
        member.issue_histories.should include issue_history1
        member.issue_histories.should include issue_history2 
      end
    end

    context 'Failure' do
      it 'should not belongs to library' do
        library1 = FactoryGirl.create(:library, phone_no:"3344556677")
        library2 = FactoryGirl.create(:library, phone_no:"3344556677")
        member1 = FactoryGirl.create(:member, library_id:library1.id)
        member2 = FactoryGirl.create(:member, library_id:library2.id)
        member1.library.id.should eq library1.id
        member1.library.id.should_not eq library2.id
        member2.library.id.should eq library2.id
        member2.library.id.should_not eq library1.id
      end
      it 'should not have books as a single object of member' do
        member = FactoryGirl.create(:member, phone_no:"467574378")
        expect { member.book }.to raise_exception
        expect { member.books }.to_not raise_exception 
      end
      it 'should not have issue_histories as a single object of member' do
        member = FactoryGirl.create(:member, phone_no:"467574378")
        expect { member.issue_history }.to raise_exception
        expect { member.issue_histories }.to_not raise_exception 
      end
    end
  end
end