class ChangeType < ActiveRecord::Migration[6.0]
  def change
  	rename_column :records, :type, :dns_type
  end
end
