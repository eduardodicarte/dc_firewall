class dc_firewall::config::rules::accept {
  $indexTable = 0
  $indexPort = 1
  
  $configs = split($dc_firewall::configAccept,',')
  
  $configs.each | String $config |{
    $configItem = split($config, ":")
    
    $table = $configItem[$indexTable]
    notice($table)
    
    $port = $configItem[$indexPort]
    notice($port) 
  }

  $msgPorta = "Liberacao da porta $dc_firewall::configAccept"
  $msg = "iptables -t filter -p tcp -I INPUT 1 -j ACCEPT -m comment --comment '$msgPorta'"
  $cmdUnless = "iptables -L | grep 'Liberacao da porta'" 

  exec{"libera_porta":
    command => $msg,
    path => ['/usr/sbin/','/usr/bin/'],
    unless => $cmdUnless
  }
  
  exec{"iptables_save_rules":
    command => "service iptables save",
    path =>  ['/usr/sbin/','/usr/bin/'],
    unless => $cmdUnless,
    require => Exec["libera_porta"],
  }
}