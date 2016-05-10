defmodule Test.Repo.Migrations.CreateCategory do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :parent_id, :integer
      add :lft, :integer
      add :rgt, :integer

      timestamps
    end

  end
end
