#   mix run -r priv/repo/seeds.exs

alias Test.Category

alias Test.Repo

Repo.delete_all(Category)

categories = [
  %Category{id: 1, name: "uno", parent_id: 0},
    %Category{id: 2, name: "dos", parent_id: 1},
      %Category{id: 3, name: "tres", parent_id: 2},
  %Category{id: 4, name: "cuatro", parent_id: 0},
    %Category{id: 5, name: "cinco", parent_id: 4},
      %Category{id: 6, name: "seis", parent_id: 5},
        %Category{id: 7, name: "siete", parent_id: 6},
          %Category{id: 8, name: "ocho", parent_id: 7},
      %Category{id: 9, name: "nueve", parent_id: 5},
      %Category{id: 10, name: "diez", parent_id: 5},
    %Category{id: 11, name: "once", parent_id: 4},
      %Category{id: 12, name: "doce", parent_id: 11}
]

Enum.map(categories, fn category ->
  Repo.insert!(category)
end)

Category.recover_tree(0,0)

#1. uno (1,12)
#  2. dos (2,5)
#    3. tres (3,4)
#  4. cuatro (6,11)
#    5. cinco (7,8)
#    6. seis (9,10)
