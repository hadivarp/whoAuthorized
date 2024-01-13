class CreateAccessTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :access_tokens do |t|
      t.references :user
      t.string :token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
