defmodule Treex.Model do
  alias Treex.Util
  import Ecto.Query

  # Requirements
  # This module requires the following columns in your models:
  #   parent_id (nullable) The column holding the ID of the parent row
  #   lft (integer) Used to maintain the tree structure
  #   rgt (integer) Used to maintain the tree structure

  defmacro __using__(_) do
		quote do
      alias __MODULE__, as: TreeModel

      def test(data \\ '')do
        IO.puts("Probando Treex/test #{data}, ejecutando desde #{TreeModel}")
        from(tm in TreeModel, limit: 10, select: tm) |> Util.repo.all
      end

      def generate_tree(list, parent_id \\ nil)do
        # from(c in Category, select: %{id: c.id, parent_id: c.parent_id, lft: c.lft, rgt: c.rgt, name: c.name})
        # |> Repo.all
        # |> Category.generate_tree(1)

        parent = if(parent_id == nil)do
          List.first(list)
        else
          Enum.find(list, nil, fn(x) -> x.id == parent_id end)
        end
        if(parent != nil)do
          children = Enum.filter_map(list,
              fn(x) ->
                x.parent_id == parent.id
              end,
              fn(y) ->
                generate_tree(list, y.id)
              end)

            parent = Map.put(parent, :children, children)
        else
          nil
        end
      end

      def recover_tree(parent_id \\ 0, lft \\ 0)do
        rgt = lft + 1
        result = from(tm in TreeModel, where: tm.parent_id == ^parent_id, select: tm.id) |> Util.repo.all

        rgt = Enum.reduce(result, rgt, fn(x, rgt) ->
          rgt = recover_tree(x, rgt)
        end)

        from(tm in TreeModel, where: tm.id == ^parent_id, update: [set: [lft: ^lft, rgt: ^rgt]]) |> Util.repo.update_all([])
        rgt + 1
      end

    end
  end
end
