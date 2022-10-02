class JoinDomains < ActiveRecord::Migration
  def up
    add_column :domains, :domain, :string
    execute "UPDATE `domains` SET `domain`=SUBSTRING_INDEX((SUBSTRING_INDEX((SUBSTRING_INDEX(url, 'http://', -1)), '/', 1)), '.', -2) WHERE 1"

    remove_column :domains, :url
    rename_column :domains, :domain, :url

    execute "ALTER IGNORE TABLE `domains` ADD UNIQUE INDEX (url)"
    execute "UPDATE `urls` SET `domain_id`=(SELECT id FROM domains WHERE domains.url=SUBSTRING_INDEX((SUBSTRING_INDEX((SUBSTRING_INDEX(urls.url, 'http://', -1)), '/', 1)), '.', -2)) WHERE 1"
  end
end
