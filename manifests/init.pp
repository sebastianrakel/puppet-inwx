# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include inwx
class inwx {
  package { 'inwx-domrobot':
    ensure => 'present',
    provider => 'puppet_gem',
  }
}
