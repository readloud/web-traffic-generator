class ChangeCampaignIdToSites < ActiveRecord::Migration
  def change
    rename_column :sites, :campaignId, :campaign_id
  end
end
