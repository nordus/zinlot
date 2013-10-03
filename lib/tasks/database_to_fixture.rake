namespace :db do
  namespace :fixtures do
    desc 'Exports data from MySQL and creates fixture.
    You can optionally specify particular tables in FIXTURES, e.g FIXTURES=users,vehicles,readings.'
    task :extract => :environment do
      sql = "SELECT * FROM %s order by id desc"
      skip_tables = ["schema_migrations"]
      tables = ENV['FIXTURES'] ? ENV['FIXTURES'].split(/,/) : ActiveRecord::Base.connection.tables - skip_tables
      tables.each do |table_name|
          i = "000"
          File.open("#{Rails.root}/test/fixtures/#{table_name}.yml", 'w') do |file|
          data = ActiveRecord::Base.connection.select_all(sql % table_name)
          file.write data.inject({}) { |hash, record|
            hash["#{table_name}_#{i.succ!}"] = record
            hash
          }.to_yaml
         end
      end
    end
  end
end