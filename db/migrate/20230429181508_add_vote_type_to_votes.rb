class AddVoteTypeToVotes < ActiveRecord::Migration[7.0]
  def change
    add_column :votes, :vote_type, :string
  end
end
