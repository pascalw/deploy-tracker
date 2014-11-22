require 'spec_helper'
require 'support/active_record'
require './app/models/deployment'

describe Deployment do
  subject(:deployment) { Deployment.create }

  describe '.create' do
    before do
      allow(Time).to receive(:now).and_return(Time.new(2014, 11, 22))
    end

    it 'sets the deployed_at timestamp to Time.now' do
      expect(deployment.deployed_at).to eq(Time.now)
    end
  end
end
