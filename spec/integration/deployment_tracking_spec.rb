require 'spec_helper'

describe 'POST /deployments/:token' do
  before do
    post "/deployments/#{token}"
  end

  context 'non existing token' do
    let(:token) { 'foobar' }

    it 'responds with 404' do
      expect(response.status).to eq(404)
    end
  end

  context 'existing token' do
    let!(:application) { Application.create(name: 'myapp') }
    let(:token) { application.token }

    it 'responds with 204' do
      expect(response.status).to eq(204)
      expect(application.deployments.size).to eq(1)
    end
  end
end
