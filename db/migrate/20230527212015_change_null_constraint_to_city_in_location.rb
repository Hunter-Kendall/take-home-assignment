class ChangeNullConstraintToCityInLocation < ActiveRecord::Migration[7.0]
  def change
    change_column_null :locations, :city, false
    change_column_null :locations, :state, false
  end
end
