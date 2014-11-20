package 'pptpd'

service 'pptpd' do
  supports start: true, stop: true, restart: true
end

template '/etc/pptpd.conf' do
  source 'pptpd.conf.erb'
  variables(
    localip: node[:pptpd][:localip],
    remoteip: node[:pptpd][:remoteip]
  )
  notifies :restart, 'service[pptpd]'
end

template '/etc/ppp/pptpd-options' do
  source 'pptpd-options.erb'
  variables dns: node[:pptpd][:dns]
  notifies :restart, 'service[pptpd]'
end

cookbook_file '/etc/sysctl.d/60-forward-ipv4.conf' do
  source '60-forward-ipv4.conf'
  notifies :run, 'execute[reload-sysctl]'
end

execute 'reload-sysctl' do
  command 'sysctl --system'
  action :nothing
end

iptables_rule 'pptpd' do
  source 'iptables-rules.erb'
  variables(
    network: node[:pptpd][:localip],
    interface: node[:pptpd][:interface]
  )
end

template '/etc/ppp/chap-secrets' do
  source 'chap-secrets.erb'
  variables users: node[:pptpd][:users]
  owner 'root'
  group 'root'
  mode 0600
  notifies :restart, 'service[pptpd]'
end
