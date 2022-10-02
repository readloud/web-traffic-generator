class AddLinksCountToDomain < ActiveRecord::Migration
  def change

    add_column :domains, :links_counter, :integer, default: 0
    add_index :domains, :links_counter

    Domain.all.each do |domain|
      links_counter = 0
      domain.urls.each do |url|
        links_counter += url.links.count
      end
      domain.links_counter = links_counter
      domain.save
    end

  end
end
