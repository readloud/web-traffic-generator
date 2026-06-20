class AddDefaultDatesToUrl < ActiveRecord::Migration
  def change
    execute 'ALTER TABLE urls CHANGE `created_at` `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP'
  end
end
