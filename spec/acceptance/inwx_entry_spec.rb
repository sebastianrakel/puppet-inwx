require 'spec_helper_acceptance'
#require 'serverspec_type_inwxclient'

describe 'inwx_entry type' do
  context 'create inwx_entry resources' do
    pp1 = <<-EOS
      inwx_entry { 'testdomain':
        username   => 'landwehr',
        password   => 'sho2Aibahquieth6nev*',
        domain     => 'landwehr.io',
        content    => '8.8.8.8',
        entry_type => 'A',
      }
    EOS

    it 'works with no error on the first apply' do
      apply_manifest(pp1, catch_failures: true)
    end

    it 'works with no error on the second apply' do
      apply_manifest(pp1, catch_failures: true)
    end
  end
end
