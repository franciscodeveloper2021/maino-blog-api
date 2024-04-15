class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 50
      t.string :last_name, null: false, limit: 50
      t.string :email, null: false, limit: 254
      t.string :password_digest, null: false

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE users ADD CONSTRAINT min_length_name
      CHECK (LENGTH(name) >= 2);

      ALTER TABLE users ADD CONSTRAINT min_length_lastname
      CHECK (LENGTH(last_name) >= 2);

      ALTER TABLE users ADD CONSTRAINT min_length_password_digest
      CHECK (LENGTH(password_digest) >= 6);
    SQL

    add_index :users, :email, unique: true
  end
end
