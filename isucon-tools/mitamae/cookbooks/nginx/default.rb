# 現在の日時を取得
current_time = Time.now.to_s.gsub(/[- :+]/, '')

# カレントディレクトリを取得
current_dir = File.dirname(__FILE__)

# nginx.confのバックアップ
execute "backup nginx.conf" do
  command "mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.#{current_time}"
  not_if "diff -q /etc/nginx/nginx.conf #{current_dir}/config/nginx.conf"
end

# nginx.confをコピー
remote_file "/etc/nginx/nginx.conf" do
  owner  "root"
  group  "root"
  source "config/nginx.conf"
  mode   "644"
end

# isucon-php.confのバックアップ
execute "backup isucon-php.conf" do
  command "mv /etc/nginx/sites-available/isucon-php.conf /etc/nginx/sites-available/isucon-php.conf.#{current_time}"
  not_if "diff -q /etc/nginx/sites-available/isucon-php.conf #{current_dir}/config/sites-available/isucon-php.conf"
end

# isucon-php.confをコピー
remote_file "/etc/nginx/sites-available/isucon-php.conf" do
  owner  "root"
  group  "root"
  source "config/sites-available/isucon-php.conf"
  mode   "644"
end

# nginxの再起動
service "nginx" do
  action :restart
end