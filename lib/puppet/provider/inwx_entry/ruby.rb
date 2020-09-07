require_relative '../inwxclient'

Puppet::Type.type(:inwx_entry).provide(:ruby, parent: Puppet::Provider::INWXCLIENT) do
  confine feature: :inwxdomrobot

  def exists?
    does_domain_exists
  end

  def create
    create_entry
  end

  def destroy
    delete_entry
  end

  def does_domain_exists
    exists_domain(resource[:username], resource[:password], resource[:debug],
                  resource[:domain],
                  resource[:name],
                  resource[:content],
                  resource[:entry_type])
  end

  def create_entry
    create_domain(resource[:username], resource[:password], resource[:debug],
                  resource[:domain],
                  resource[:name],
                  resource[:content],
                  resource[:entry_type])
  end

  def delete_entry
    delete_domain(resource[:username], resource[:password], resource[:debug],
                  resource[:domain],
                  resource[:name],
                  resource[:content],
                  resource[:entry_type])
  end
end
