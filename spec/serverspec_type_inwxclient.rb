require 'json'
require 'inwx-domrobot'

module Serverspec::Type
  class Inwxclient < Base
    def initialize(user, pass)
      @domrobot = INWX::Domrobot.new
      result = @domrobot.set_language('en')
                        .use_ota
                        .use_json
                        .debug(debug)
                        .login(user, pass)

      if result['code'] != 1000
        return nil
      end
    end

    def result
      @response['result']
    end

    private

    def token
      @token ||= retrieve_token
    end

    def retrieve_token
      data = {
          jsonrpc: '2.0',
          method: 'user.login',
          params: {
              user: @user,
              password: @pass
          },
          auth: nil,
          id: 0
      }.to_json
      do_request(data)['result']
    end

    def query(method, params)
      data = {
          jsonrpc: '2.0',
          method: method,
          params: params,
          auth: token,
          id: 0
      }.to_json
      do_request(data)
    end

    def do_request(data)
      command = "#{@curl_base} '#{data}'"
      result = @runner.run_command(command)
      JSON.parse(result.stdout.chomp)
    end
  end
  def inwxclient(user, pass)
    Inwxclient.new(user, pass)
  end
end
include Serverspec::Type
