class AddUniqueToUrl < ActiveRecord::Migration
  def up
    execute "ALTER IGNORE TABLE `urls` ADD UNIQUE INDEX (url)"
  end
  def down
    execute "ALTER TABLE urls DROP INDEX url"
  end
end
