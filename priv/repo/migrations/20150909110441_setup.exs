defmodule Foo.Repo.Migrations.Setup do
  use Ecto.Migration

  def change do
    create table(:typed_table) do
      add :type,    :string

      timestamps
    end
  end
end
