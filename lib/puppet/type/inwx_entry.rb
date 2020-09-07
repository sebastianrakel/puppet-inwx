Puppet::Type.newtype(:inwx_entry) do
  desc 'INWX Domain Entry'

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc 'Name of Entry'
  end

  newparam(:content) do
    desc 'Content like IP Address'
  end

  newparam(:domain) do
    desc 'Domain which should be managed'
  end

  newparam(:username) do
    desc 'INWX Username'
  end

  newparam(:password) do
    desc 'INWX Password'
  end

  newparam(:entry_type) do
    desc 'Entry Type (A)'

    newvalues('A')
  end

  newparam(:debug) do
    desc 'Get Debug Output from INWX'
    defaultto :false
    newvalues(:true, :false)
  end
end
