import gleam/dict
import gleam/io
import gleam/list
import gleam/string

pub fn follow_word(grid, pos, direction, remaining) {
  let #(x, y) = pos
  let #(dx, dy) = direction

  let new_x = x + dx
  let new_y = y + dy

  case remaining {
    [] -> True
    [letter, ..rest] -> {
      case dict.get(grid, #(new_x, new_y)) {
        Error(_) -> False
        Ok(char) if char != letter -> False
        Ok(_) -> follow_word(grid, #(new_x, new_y), direction, rest)
      }
    }
  }
}

pub fn find_xmas(input) {
  let items =
    input
    |> string.split("\n")
    |> list.map(string.split(_, ""))
    |> list.index_map(fn(line, y) {
      list.index_map(line, fn(char, x) { #(#(x, y), char) })
    })
    |> list.flatten
  let grid = dict.from_list(items)

  let starting_positions =
    list.map(items, fn(item) {
      let #(pos, char) = item
      case char {
        "X" -> Ok(pos)
        _ -> Error(Nil)
      }
    })
    |> list.filter_map(fn(x) { x })

  io.debug(follow_word(grid, #(5, 0), #(1, 0), ["M", "A", "S"]))

  let directions = [
    #(1, 0),
    #(1, 1),
    #(0, 1),
    #(-1, 1),
    #(-1, 0),
    #(-1, -1),
    #(0, -1),
    #(1, -1),
  ]

  let part_1 =
    list.fold(starting_positions, 0, fn(acc, pos) {
      let a =
        list.filter(directions, fn(direction) {
          follow_word(grid, pos, direction, ["M", "A", "S"])
        })
        |> list.length
      a + acc
    })

  let part_2 =
    list.map(items, fn(item) {
      let #(pos, char) = item
      case char {
        "A" -> Ok(pos)
        _ -> Error(Nil)
      }
    })
    |> list.filter_map(fn(x) { x })
    |> list.filter(fn(pos) {
      let #(x, y) = pos

      case dict.get(grid, #(x - 1, y - 1)), dict.get(grid, #(x + 1, y + 1)) {
        Ok("M"), Ok("S") | Ok("S"), Ok("M") -> {
          case
            dict.get(grid, #(x - 1, y + 1)),
            dict.get(grid, #(x + 1, y - 1))
          {
            Ok("M"), Ok("S") | Ok("S"), Ok("M") -> True
            _, _ -> False
          }
        }
        _, _ -> False
      }
    })
    |> list.length

  #(part_1, part_2)
}
