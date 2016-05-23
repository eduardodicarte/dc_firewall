# Class: puppetfirewall
#
# This module manages puppetfirewall
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class dc_firewall(String $configAccept) {
  include ::dc_firewall::install
}
