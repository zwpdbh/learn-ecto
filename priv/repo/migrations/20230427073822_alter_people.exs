defmodule Friends.Repo.Migrations.AlterPeople do
  use Ecto.Migration

  def change do
    rename table(:people), :agen, to: :age
  end
end
