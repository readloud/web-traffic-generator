class AddStatusToDomains < ActiveRecord::Migration
  def change
    add_reference :domains, :status, index: true

    Domain.all.each do |domain|
      if domain.urls.first
        domain.status_id = domain.urls.first.status_id
        domain.save
      end
    end

    remove_reference :urls, :status
  end
end
