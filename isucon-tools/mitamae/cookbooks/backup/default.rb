MYSQL_USER = 'root'
MYSQL_PASSWORD = 'root'
MYSQL_DATABASE = 'isuports'
DUMP_DIR = "/home/isucon/work"
DUMP_FILE = "#{DUMP_DIR}/dump.sql"

# ディレクトリの生成
directory DUMP_DIR do
  action :create
end

# dumpファイルの作成
execute "Dump MySQL structure" do
  command "mysqldump --user=#{MYSQL_USER} --password=#{MYSQL_PASSWORD} #{MYSQL_DATABASE} > #{DUMP_FILE}"
end
