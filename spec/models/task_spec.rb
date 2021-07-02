require 'rails_helper'
describe 'Task model function', type: :model do
  context 'Validation test' do
    it 'It ensures title is present' do
      task = Task.new(title: '', content: 'fail test').save
      expect(task).to eq(false)
    end
    it 'It ensures content is present' do
      task = Task.new(title: 'title', content: '').save
      expect(task).to eq(false)
    end
    it 'Validation passes' do
      task = Task.new(title: 'title', content: 'pass test', deadline: '2021/1/1', status: 'Complete', priority: 'Low').save
      expect(task).to eq(true)
    end
  end
  describe 'Search function' do
    context 'When fuzzy search of title is performed by scope method' do
      it "Tasks containing search keywords are narrowed down" do
        Task.create(title: "title1", content: "content1", deadline: "2021/1/1", status:"Complete", priority: "Low")
        expect(Task.search_title("title1").count).to eq 1
      end
    end
    context 'When fuzzy search of status is performed by scope method' do
      it "Tasks containing status are narrowed down" do
        Task.create(title: "title1", content: "content1", deadline: "2021/1/1", status:"Complete", priority: "Low")
        expect(Task.search_status("Complete").count).to eq 1
      end
    end
    context 'When fuzzy search of both title and status is performed by scope method' do
      it "Tasks containing search keywords and status are narrowed down" do
        Task.create(title: "title1", content: "content1", deadline: "2021/1/1", status:"Complete", priority: "Low")
        expect(Task.search_title("title1").count).to eq 1
        expect(Task.search_status("Complete").count).to eq 1
      end
    end
  end
end
