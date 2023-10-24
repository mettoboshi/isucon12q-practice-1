# Goのインストール
package 'golang' do
  action :install
end

# tideways/toolkit のインストール
execute "Install tideways toolkit using go" do
  command "go install github.com/tideways/toolkit@latest"
  not_if "test -e $(go env GOPATH)/bin/twcli"
end