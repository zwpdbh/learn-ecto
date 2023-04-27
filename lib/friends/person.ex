defmodule Friends.Person do
  use Ecto.Schema
  require Ecto.Query

  schema "people" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:age, :integer)
  end

  def changeset(person, params \\ %{}) do
    person
    |> Ecto.Changeset.cast(params, [:first_name, :last_name, :age])
    |> Ecto.Changeset.validate_required([:first_name, :last_name])
  end

  def demo_insert_test_data do
    people = [
      %Friends.Person{first_name: "Ryan", last_name: "Bigg", age: 28},
      %Friends.Person{first_name: "John", last_name: "Smith", age: 27},
      %Friends.Person{first_name: "Jane", last_name: "Smith", age: 26}
    ]

    Enum.each(people, fn person -> Friends.Repo.insert(person) end)
  end

  def demo_query_one_v1 do
    Friends.Person |> Ecto.Query.first() |> Friends.Repo.one()
  end

  def demo_query_one_v2 do
    Ecto.Query.from(p in Friends.Person, order_by: [asc: p.id], limit: 1) |> Friends.Repo.one()
  end

  def demo_query_all do
    Friends.Person |> Friends.Repo.all()
  end

  def demo_query_with_id do
    Friends.Person |> Friends.Repo.get(1)
  end

  def demo_query_with_value do
    Friends.Person |> Friends.Repo.get_by(first_name: "Ryan")
  end

  def demo_filter_results_v1 do
    last_name = "Smith"
    Friends.Person |> Ecto.Query.where(last_name: ^last_name) |> Friends.Repo.all()
  end

  def demo_filter_results_v2 do
    last_name = "Smith"
    Ecto.Query.from(p in Friends.Person, where: p.last_name == ^last_name) |> Friends.Repo.all()
  end

  def demo_query_compose do
    Friends.Person
    |> Ecto.Query.where(last_name: "Smith")
    |> Ecto.Query.where(first_name: "Jane")
  end

  def demo_update do
    Friends.Person
    |> Ecto.Query.first()
    |> Friends.Repo.one()
    # After fetch a record we create a changeset
    |> Friends.Person.changeset(%{age: 29})
    # Then, call update
    |> Friends.Repo.update()
  end

  def demo_delete do
    Friends.Repo.get(Friends.Person, 1) |> Friends.Repo.delete()
  end
end
