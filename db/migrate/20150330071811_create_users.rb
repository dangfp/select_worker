class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :password_digest, :full_name, :phone

      t.timestamps
    end
  end
end
