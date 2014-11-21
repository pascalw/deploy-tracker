require 'spec_helper'
require 'support/active_record'
require './app/models/application'

describe Application do
  subject(:application) { Application.create(name: 'my app') }

  describe '#token' do
    context 'create' do
      it 'generates a token' do
        expect(application.token.length).to eq(16)
      end
    end

    context 'update' do
      before do
        @original_token = application.token
        application.save
      end

      it 'does not overwrite an existing token' do
        expect(application.token).to eq(@original_token)
      end
    end
  end

  describe '#track_deployment!' do
    it 'creates a deployment record' do
      expect { application.track_deployment! }.to change{ application.deployments.count }.by(1)
    end
  end
end
