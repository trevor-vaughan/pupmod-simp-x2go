require 'spec_helper_acceptance'

test_name 'x2go with MATE'

describe 'x2go with MATE' do
  let(:manifest) {
    <<-EOS
      class { 'x2go': server => true }
      class { 'gnome': enable_mate => true }
    EOS
  }

  hosts.each do |host|
    context "on #{host}" do
      it 'should work with no errors' do
        apply_manifest_on(host, manifest, :catch_failures => true)
      end

      it 'should be idempotent' do
        apply_manifest_on(host, manifest, :catch_changes => true)
      end
    end
  end
end
