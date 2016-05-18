class dcfirewall::install{
  package {'firewalld':
    ensure => absent
  }
  
  package { 'iptables-services':
    ensure  => present,
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