defmodule Test.Category do
  use Test.Web, :model
  use Treex.Model

  schema "categories" do
    field :name, :string
    field :parent_id, :integer
    field :lft, :integer
    field :rgt, :integer

    timestamps
  end

  @required_fields ~w(name parent_id lft rgt)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
