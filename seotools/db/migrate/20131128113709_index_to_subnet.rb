class IndexToSubnet < ActiveRecord::Migration
  def up
    add_index :subnets, :links_count

    Subnet.all.each do |subnet|
      count = 0
      subnet.domains.each do |domain|
        count = count + domain.links_counter
      end
      subnet.links_count = count
      subnet.save
    end
  end
  def down
    remove_index :subnets, :links_count
  end
end
