class CreateDeployments < ActiveRecord::Migration
  def change
    create_table :deployments do |t|
      t.datetime 'deployed_at'

      t.references :application
    end
  end
end
