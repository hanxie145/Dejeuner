class RemoveTypeFromCampaign < ActiveRecord::Migration
  def change
    remove_column :campaigns, :type, :string
  end
end
