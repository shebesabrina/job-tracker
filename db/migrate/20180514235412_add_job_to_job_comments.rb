class AddJobToJobComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :job_comments, :job, index: true, foreign_key: true
  end
end
