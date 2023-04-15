class AddPasswordDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_digest, :string

    User.all.each do |user|
      user.update(password_digest: user.password_digest)
    end

    remove_column :users, :password
  end
end
