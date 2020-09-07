require 'json'
require 'net/http'
require 'openssl'
require 'inwx-domrobot'
require 'pp'

class Puppet::Provider::INWXCLIENT < Puppet::Provider
  class << self
  end

  $domrobot = nil

  def login(username, password, debug)
    if $domrobot != nil
      return $domrobot
    end

    $domrobot = INWX::Domrobot.new
    result = $domrobot.set_language('en')
                      .use_live
                      .use_json
                      .debug(debug)
                      .login(username, password)

    if result['code'] != 1000
      return nil
    end

    $domrobot
  end

  def logout()
    if $domrobot != nil
      $domrobot.logout
    end
    $domrobot = nil
  end

  def domain_info(username, password, debug, domain, name, content, entry_type)
    domrobot = login(username, password, debug)

    object = 'nameserver'
    method = 'info'
    params = {
        'domain' => domain,
        'name' => "#{name}.#{domain}",
        'type' => entry_type,
        'content' => content,
    }

    begin
      return domrobot.call(object, method, params)
    ensure
      logout
    end
  end

  def exists_domain(username, password, debug, domain, name, content, entry_type)
    result = domain_info(username, password, debug, domain, name, content, entry_type)
    result['resData']['count'] == 1
  end

  def create_domain(username, password, debug, domain, name, content, entry_type)
    domrobot = login(username, password, debug)

    object = 'nameserver'
    method = 'createrecord'
    params = {
      'domain' => domain,
      'type' => entry_type,
      'content' => content,
      'name' => name,
    }

    begin
      result = domrobot.call(object, method, params)
      return result['code'] == 1000
    ensure
      logout
    end
  end

  def delete_domain(username, password, debug, domain, name, content, entry_type)
    result = domain_info(username, password, debug, domain, name, content, entry_type)

    if result['resData']['count'] == 1
      domrobot = login(username, password)

      object = 'nameserver'
      method = 'deleterecord'
      params = {
          'id' => result['resData']['record'][0]['id'],
      }

      begin
        result = domrobot.call(object, method, params)
        return result['code'] == 1000
      ensure
        logout
      end
    end
  end
end
