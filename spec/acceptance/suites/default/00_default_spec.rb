require 'spec_helper_acceptance'

test_name 'x2go class'

describe 'x2go class' do
  let(:manifest) {
    <<-EOS
      class { 'x2go': }
    EOS
  }

  let(:server_manifest) {
    <<-EOS
      class { 'x2go': server => true }
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

      it 'should have the client installed' do
        host.check_for_package('x2goclient').should be true
      end
    end

    context 'as a server' do
      it 'should work with no errors' do
        apply_manifest_on(host, server_manifest, :catch_failures => true)
      end

      it 'should be idempotent' do
        apply_manifest_on(host, server_manifest, :catch_changes => true)
      end

      it 'should have the client installed' do
        host.check_for_package('x2goserver').should be true
      end
    end
  end
end
