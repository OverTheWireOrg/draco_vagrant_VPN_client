class client_fw {
  Firewall {
    before  => Class['client_fw::post'],
    require => Class['client_fw::pre'],
  }

  class { ['client_fw::pre', 'client_fw::post']: }

  #Logging for various interesting subnets
  firewall {'100 Log eth0 from local or non-routable':
    chain       => 'FW_eth0_INPUT',
    action      => 'log',
    log_prefix  => 'eth-INPUT DROP LOCAL: ',
    source      => '0.0.0.0/8',
  }
  firewall {'100 Log eth0 from Class A private':
    chain       => 'FW_eth0_INPUT',
    action      => 'log',
    log_prefix  => 'eth-INPUT DROP A: ',
    source      => '10.0.0.0/8',
  }
  firewall {'100 Log eth0 from Loopback':
    chain       => 'FW_eth0_INPUT',
    action      => 'log',
    log_prefix  => 'eth-INPUT DROP LOOPBACK: ',
    destination => '127.0.0.0/8',
  }
  firewall {'100 Log eth0 from APIPA/Link-Local':
    chain       => 'FW_eth0_INPUT',
    action      => 'log',
    log_prefix  => 'eth-INPUT DROP APIPA/LINK-LOCAL: ',
    source      => '169.254.0.0/16',
  }
  firewall {'100 Log eth0 from Class B private':
    chain       => 'FW_eth0_INPUT',
    action      => 'log',
    log_prefix  => 'eth-INPUT DROP B: ',
    source      => '172.16.0.0/12',
  }
  firewall {'100 Log eth0 from Class C private':
    chain       => 'FW_eth0_INPUT',
    action      => 'log',
    log_prefix  => 'eth-INPUT DROP C: ',
    source      => '192.168.0.0/16',
  }
  firewall {'100 Log eth0 from Multicast':
    chain       => 'FW_eth0_INPUT',
    action      => 'log',
    log_prefix  => 'eth-INPUT DROP MULTICAST: ',
    source      => '224.0.0.0./4',
  }
  firewall {'100 Log eth0 from Class E':
    chain       => 'FW_eth0_INPUT',
    action      => 'log',
    log_prefix  => 'eth-INPUT DROP E: ',
    source      => '240.0.0.0/4',
  }
  firewall {'100 Log eth0 from Reserved':
    chain       => 'FW_eth0_INPUT',
    action      => 'log',
    log_prefix  => 'eth-INPUT DROP RESERVED: ',
    source      => '240.0.0.0/4',
  }
  firewall {'100 Log eth0 from Broadcast':
    chain       => 'FW_eth0_INPUT',
    action      => 'log',
    log_prefix  => 'eth-INPUT DROP BROADCAST: ',
    source      => '255.255.255.255/32',
  }
  firewall { '101 accept related established rules, eth0':
      chain  => 'FW_eth0_INPUT',
      proto  => 'all',
      state  => ['RELATED', 'ESTABLISHED'],
      action => 'accept',
  }
  firewall { '101 accept related established rules, tun0':
      chain  => 'FW_tun0_INPUT',
      proto  => 'all',
      state  => ['RELATED', 'ESTABLISHED'],
      action => 'accept',
  }

  firewall { '999 drop all FW_eth0_INPUT':
      chain  => 'FW_eth0_INPUT',
      proto  => 'all',
      action => 'drop',
  }

  firewall { '999 drop all FW_tun0_INPUT':
      chain  => 'FW_tun0_INPUT',
      proto  => 'all',
      action => 'drop',
  }
}