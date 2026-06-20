development:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  database: seotool_dev
  pool: 5
  username: root
  password:
  host: localhost
  port: 3306

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  database: seotool_test
  pool: 5
  username: root
  password:
  host: localhost
  port: 3306

production:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  database: seotool_prod
  pool: 5
  host: localhost
  port: 3306