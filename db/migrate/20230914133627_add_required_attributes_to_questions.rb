class AddRequiredAttributesToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :question_number, :integer
    add_column :questions, :score, :integer
  end
end
