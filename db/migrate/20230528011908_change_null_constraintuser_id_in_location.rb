class ChangeNullConstraintuserIdInLocation < ActiveRecord::Migration[7.0]
  def change
    change_column_null :locations, :user_id, false
  end
end
