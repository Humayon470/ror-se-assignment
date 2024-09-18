class ImportBlogsInteractor
  include Interactor

  delegate :current_user, :file, to: :context

  def call
    #Used indexing approach for Bulk data
    blogs_data = []

    CSV.foreach(file.path, headers: true, encoding: 'utf-8').with_index do |row, index|
      blog_attributes = row.to_hash.slice(*Blog.column_names)
      blog_attributes['user_id'] = current_user.id
      blogs_data << blog_attributes
    end

    #Used insert all to save all record in just one querry
    ActiveRecord::Base.transaction do
      Blog.insert_all(blogs_data)
    end

    context.flash_message = "Blogs imported successfully!"
  rescue StandardError => e
    context.flash_message = "An error occurred while importing blogs: #{e.message}"
  end
end