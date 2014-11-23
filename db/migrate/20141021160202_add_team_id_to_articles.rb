class AddTeamIdToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :team_id, :integer

    set_team_id if Article.any?

    change_column :articles, :team_id, :integer, null: false
  end

  def down
    remove_column :articles, :team_id
  end

  def set_team_id
    team = Team.first_or_create(name: "First Team")
    Article.all.each do |a|
      a.update_attributes!(team_id: team.id)
    end
  end
end
