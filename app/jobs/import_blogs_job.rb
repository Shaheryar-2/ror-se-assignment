class ImportBlogsJob < ApplicationJob
  queue_as :default

  def perform(user, file)
    data = CSV.parse(file.to_io, headers: true, encoding: 'utf-8')
    
    # Start code to handle CSV data
    ActiveRecord::Base.transaction do
      data.each do |row|
        user.blogs.create!(row.to_h)
      end
    end
    # Assumption::Once job is completed we can notify the user about job completion 
  end
end
