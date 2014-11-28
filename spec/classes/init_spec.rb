require 'spec_helper'
describe 'role_reverseproxy' do

  context 'with defaults for all parameters' do
    it { should contain_class('role_reverseproxy') }
  end
end
