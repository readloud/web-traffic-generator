class AddDomainsCountToSubnets < ActiveRecord::Migration
  def change
    add_column :subnets, :domains_count, :integer
    add_index :subnets, :domains_count
  end
end
