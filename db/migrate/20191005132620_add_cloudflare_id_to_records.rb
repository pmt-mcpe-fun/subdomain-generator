class AddCloudflareIdToRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :cloudflare_id, :string
  end
end
