#   mix run -r priv/repo/seeds.exs

alias Test.Category

alias Test.Repo

Repo.delete_all(Category)

#categories = [
#  %Category{id: 1, name: "uno", parent_id: 0, lft: 1, rgt: 12},
#  %Category{id: 2, name: "dos", parent_id: 1, lft: 2, rgt: 5},
#  %Category{id: 3, name: "tres", parent_id: 2, lft: 3, rgt: 4},
#  %Category{id: 4, name: "cuatro", parent_id: 1, lft: 6, rgt: 11},
#  %Category{id: 5, name: "cinco", parent_id: 4, lft: 7, rgt: 8},
#  %Category{id: 6, name: "seis", parent_id: 4, lft: 9, rgt: 10}
#]

categories = [
  %Category{id: 1, name: "uno", parent_id: 0, lft: nil, rgt: nil},
  %Category{id: 2, name: "dos", parent_id: 1, lft: nil, rgt: nil},
  %Category{id: 3, name: "tres", parent_id: 2, lft: nil, rgt: nil},
  %Category{id: 4, name: "cuatro", parent_id: 1, lft: nil, rgt: nil},
  %Category{id: 5, name: "cinco", parent_id: 4, lft: nil, rgt: nil},
  %Category{id: 6, name: "seis", parent_id: 4, lft: nil, rgt: nil}
]

Enum.map(categories, fn category ->
  Repo.insert!(category)
end)

#1. uno (1,12)
#  2. dos (2,5)
#    3. tres (3,4)
#  4. cuatro (6,11)
#    5. cinco (7,8)
#    6. seis (9,10)
