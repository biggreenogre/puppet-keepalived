require 'spec_helper'

describe 'keepalived::vrrp::unicast_peer', :type => :define do
  let (:title) { '10.0.1.0' }
  let (:facts) { debian_facts }
  let (:pre_condition) { '$concat_basedir = "/tmp"' }
  let (:mandatory_params) {
    {
      :instance         => '_VALUE_',
    }
  }

  describe 'without parameters' do
    it do
      expect { should create_class('keepalived') }.to raise_error(Puppet::Error)
    end
  end

  describe 'with parameter instance' do
    let (:params) {
      mandatory_params.merge({
        :instance => '_VALUE_',
      })
    }

    it { should create_keepalived__vrrp__unicast_peer('10.0.1.0') }
    it {
      should \
        contain_concat__fragment('keepalived.conf_vrrp_instance__VALUE__upeers_peer_10.0.1.0').with(
          'content' => /\s+10\.0\.1\.0/
      )
    }
  end

end
