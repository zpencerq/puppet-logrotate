require 'spec_helper'

describe '::logrotate::defaults' do
  context 'On supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        case facts[:osfamily]
        when 'Debian'
          it do
            should contain_logrotate__rule('wtmp').with({
              'rotate_every' => 'month',
              'rotate'       => '1',
              'create'       => true,
              'create_mode'  => '0664',
              'create_owner' => 'root',
              'create_group' => 'utmp',
              'missingok'    => true,
            })

            should contain_logrotate__rule('btmp').with({
              'rotate_every' => 'month',
              'rotate'       => '1',
              'create'       => true,
              'create_mode'  => '0600',
              'create_owner' => 'root',
              'create_group' => 'utmp',
              'missingok'    => true,
            })
          end
        when 'RedHat'
          it do
            should contain_logrotate__rule('wtmp').with({
              'path'         => '/var/log/wtmp',
              'create_mode'  => '0664',
              'missingok'    => false,
              'minsize'      => '1M',
              'rotate_every' => 'month',
              'create'       => true,
              'create_owner' => 'root',
              'create_group' => 'utmp',
              'rotate'       => '1',
            })

            should contain_logrotate__rule('btmp').with({
              'path'         => '/var/log/btmp',
              'create_mode'  => '0600',
              'minsize'      => '1M',
              'missingok'    => true,
              'rotate_every' => 'month',
              'create'       => true,
              'create_owner' => 'root',
              'create_group' => 'utmp',
              'rotate'       => '1',
            })
          end
        end
      end
    end
  end
end
