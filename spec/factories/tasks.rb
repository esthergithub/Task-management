FactoryBot.define do
  factory :task do
    # Please change the following contents according to the column name actually created
    title { 'test_title' }
    content { 'test_content' }
    deadline { '002020-11-24'}
    user

  end

  factory :second_task, class: Task do
    # Please change the following contents according to the column name actually created
    title { 'test_title1' }
    content { 'test_content2' }
    deadline { '002020-11-24'}
    user

  end
  factory :third_task, class: Task do
    title { 'sample3' }
    content { 'sample 3' }
    duedate{ '002020-11-24' }
    user
  end
end
