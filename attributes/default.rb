default[:pptpd][:dns] = %w(8.8.8.8 8.8.4.4)
default[:pptpd][:localip] = '192.168.0.1'
default[:pptpd][:remoteip] = '192.168.0.100-200'

default[:pptpd][:interface] = 'eth0'

default[:pptpd][:users] = [] # username, server, password, ip
