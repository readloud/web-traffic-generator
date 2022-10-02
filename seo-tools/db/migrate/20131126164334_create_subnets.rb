class CreateSubnets < ActiveRecord::Migration
  def up
    create_table :subnets do |t|
      t.string :ip
      t.integer :urls_count, default: 0
      t.integer :links_count, default: 0

      t.timestamps
    end

    add_reference :domains, :subnet, index: true

    execute sql_url_counter_population
    execute sql_relate_domains_to_subnets
    counters
  end

  def down
    drop_table :subnets
    remove_column :domains, :subnet_id
  end

  def sql_url_counter_population
    "INSERT INTO subnets (ip)
    SELECT
       substr( ip, 1, locate( '.', ip, locate( '.', ip, locate( '.', ip ) + 1 ) + 1 ) - 1 ) as subip
    from urls
    group by ( subip )"
  end

  def sql_relate_domains_to_subnets
    "UPDATE domains d CROSS JOIN (
        SELECT
         d.id as group_id,
           s.id as subnet_id
        FROM
        urls u, domains d, subnets s
      WHERE u.domain_id = d.id
        AND convert(s.ip USING utf8) = convert(substr( u.ip, 1, locate( '.', u.ip, locate( '.', u.ip, locate( '.', u.ip ) + 1 ) + 1 ) - 1 ) USING utf8)
        GROUP BY ( d.id )
        ORDER BY s.id ASC
    ) AS x
    SET d.subnet_id = x.subnet_id
    WHERE d.id = x.group_id"
  end

  def counters
    Subnet.all.each do |subnet|
      subnet.domains.each do |domain|
        subnet.links_count = subnet.links_count + domain.links_counter
        subnet.urls_count = subnet.urls_count + domain.urls.count
        subnet.save
      end
    end
  end
end
