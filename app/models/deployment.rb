class Deployment < ActiveRecord::Base
  belongs_to :application

  before_create :set_deployed_at

  private def set_deployed_at
    self.deployed_at = Time.now
  end
end
