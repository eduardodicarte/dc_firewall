class dc_firewall::install{
  
  $iptablesVersion = '1.4.21-16.el7'
  
  package {'firewalld':
    ensure => absent
  }
  
  package { 'iptables-services':
    ensure  => $iptablesVersion,
    require => Package['firewalld']
  }
  
  service { 'iptables':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['iptables-services']
  }
}