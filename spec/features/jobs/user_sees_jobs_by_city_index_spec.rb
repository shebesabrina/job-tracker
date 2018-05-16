require 'rails_helper'

describe 'user visits jobs by city index' do
  it 'sees a denver jobs index' do
    denver_path = '/jobs?city=Denver'
    company = Company.create!(name: "ESPN")
    job1 = company.jobs.create!(title: "farmer", level_of_interest: 70, city: "Seattle")
    job2 = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver")
    job3 = company.jobs.create!(title: "fisherman ", level_of_interest: 70, city: "Denver")

    visit denver_path


    expect(current_path).to eq(jobs_path)
    expect(page).to have_content(job2.title)
    expect(page).to have_content(job2.city)
    expect(page).to have_content(job3.title)
    expect(page).to have_content(job3.city)
  end
end
