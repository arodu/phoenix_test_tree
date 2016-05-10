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

      def recover_tree(parent \\ nil)do

        cond do
          parent == nil ->
            # actions

          is_list(parent) ->
            # actions

          true ->
            # actions

        end


        if(parent_id == nil)do
          from(tm in TreeModel,
            select: tm
          ) |> Util.repo.all
        end



      end

    end
  end
end
