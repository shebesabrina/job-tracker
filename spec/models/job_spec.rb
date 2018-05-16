require 'rails_helper'

describe Job do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without a title' do
        job = Job.new(level_of_interest: 80, description: 'Wahoo', city: 'Denver')
        expect(job).to be_invalid
      end

      it 'is invalid without a level of interest' do
        job = Job.new(title: 'Developer', description: 'Wahoo', city: 'Denver')
        expect(job).to be_invalid
      end

      it 'is invalid without a city' do
        job = Job.new(title: 'Developer', description: 'Wahoo', level_of_interest: 80)
        expect(job).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with a title, level of interest, and company' do
        company = Company.create!(name: 'Turing')
        category = Category.create!(title: 'Develoer')
        job = company.jobs.create(title: 'Developer', level_of_interest: 40, city: 'Denver', category_id: category.id)
        expect(job).to be_valid
      end
    end
  end

  describe 'relationships' do
    it {should belong_to(:company)}
  end

  describe 'class methods' do
    it 'can sort jobs by city' do
      category = Category.create!(title: 'Dev')
      company = Company.create!(name: "ESPN")
      company.jobs.create!(title: "farmer", level_of_interest: 70, city: "Seattle", category_id: category.id)
      job1 = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
      company.jobs.create!(title: "fisherman ", level_of_interest: 70, city: "Denver", category_id: category.id)

      job_by_city = Job.all.city_select(job1.city)

      expect(job_by_city.count).to eq(2)
    end

    it 'can count jobs by city' do
      category = Category.create!(title: 'Dev')
      company = Company.create!(name: "ESPN")
      job1 = company.jobs.create!(title: "farmer", level_of_interest: 70, city: "Seattle", category_id: category.id)
      job2 = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
      company.jobs.create!(title: "fisherman ", level_of_interest: 70, city: "Denver", category_id: category.id)

      denver_count = Job.all.where(city: job2.city).count
      seattle_count = Job.all.where(city: job1.city).count
      
      expect(denver_count).to eq(2)
      expect(seattle_count).to eq(1)
    end
  end
end
