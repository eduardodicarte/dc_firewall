class dc_firewall::config::rules::accept {
  $indexLineNumber = 0
  $indexChain = 1
  $indexPort = 2

  $configs = split($dc_firewall::configAccept, ',')

  $configs.each |String $config| {
    $configItem = split($config, ":")

    $lineNumber = $configItem[$indexLineNumber]
    $chain = $configItem[$indexChain]
    $port = $configItem[$indexPort]

    $msgPorta = "Liberacao da porta $port"
    $msg = "iptables -t filter -p tcp -I $chain $lineNumber --dport $port -j ACCEPT -m comment --comment '$msgPorta'"
    $cmdUnless = "iptables -L | grep '$msgPorta'"

    exec { "libera_porta_$port":
      command => $msg,
      path    => ['/usr/sbin/', '/usr/bin/'],
      unless  => $cmdUnless
    }

    exec { "iptables_save_rules_port_$port":
      command => "service iptables save",
      path    => ['/usr/sbin/', '/usr/bin/'],
      unless  => $cmdUnless,
      require => Exec["libera_porta_$port"],
    }
  }
}