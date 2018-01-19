require 'rails_helper'

RSpec.describe IssueHistory, type: :model do
  context 'Validations' do
    context 'Success' do
      it 'should be a valid issue_history with entries from FactoryGirl' do
        FactoryGirl.build(:issue_history).should be_valid
      end
      it 'should be a valid issue_history with manual entries' do
        FactoryGirl.build(:issue_history, issue_date:"01-02-2015", return_date:"02-04-2016").should be_valid
      end
      it 'should be a valid issue_history with manual entries' do
        FactoryGirl.build(:issue_history, issue_date:"01-02-2015", copies:3).should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid issue_history with nil issue_date' do
        FactoryGirl.build(:issue_history, issue_date:nil).should_not be_valid
      end
      it 'should not be a valid issue_history with nil return_date' do
        FactoryGirl.build(:issue_history, return_date:nil).should_not be_valid
      end
      it 'should not be a valid issue_history with nil issue_date and return_date' do
        FactoryGirl.build(:issue_history, issue_date:nil, return_date:nil).should_not be_valid
      end
      it 'should not be a valid issue_history with invalid copies' do
        FactoryGirl.build(:issue_history, copies:"abc").should_not be_valid
      end
      it 'should not be a valid issue_history with invalid copies greater than 3' do
        FactoryGirl.build(:issue_history, copies:78).should_not be_valid
      end
      it 'should not be a valid issue_history with invalid copies less than 1' do
        FactoryGirl.build(:issue_history, copies:0).should_not be_valid
      end
    end
  end

  context 'Associations' do
    context 'Success' do
      it 'should belongs to member' do
        member = FactoryGirl.create(:member, phone_no:"3344556677")
        issue_history = FactoryGirl.create(:issue_history, member_id:member.id)
        issue_history.member.id.should eq member.id
      end
      it 'should have many books' do
        issue_history = FactoryGirl.create(:issue_history)
        book1 = FactoryGirl.create(:book, issue_history_ids:issue_history.id)
        book2 = FactoryGirl.create(:book, issue_history_ids:issue_history.id)
        issue_history.books.should include book1
        issue_history.books.should include book2 
      end
    end

    context 'Failure' do
      it 'should not belongs to member' do
        member1 = FactoryGirl.create(:member, phone_no:"3344556677")
        member2 = FactoryGirl.create(:member, phone_no:"3344556677")
        issue_history1 = FactoryGirl.create(:issue_history, member_id:member1.id)
        issue_history2 = FactoryGirl.create(:issue_history, member_id:member2.id)
        issue_history1.member.id.should eq member1.id
        issue_history1.member.id.should_not eq member2.id
        issue_history2.member.id.should eq member2.id
        issue_history2.member.id.should_not eq member1.id
      end
      it 'should not have books as a single object of issue_history' do
        issue_history = FactoryGirl.create(:issue_history)
        expect { issue_history.book }.to raise_exception
        expect { issue_history.books }.to_not raise_exception 
      end
    end
  end
end
