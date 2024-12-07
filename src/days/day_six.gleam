import gleam/dict
import gleam/list
import gleam/result
import gleam/string

fn step(grid, pos: #(Int, Int), direction: #(Int, Int), visited) {
  let #(x, y) = pos
  let #(dx, dy) = direction

  let new_x = x + dx
  let new_y = y + dy

  // io.debug(#(new_x, new_y, dict.get(grid, #(new_x, new_y))))

  case dict.get(grid, #(new_x, new_y)) {
    Ok(char) if char == "." || char == "^" -> {
      let visited = dict.insert(visited, #(new_x, new_y), True)
      step(grid, #(new_x, new_y), direction, visited)
    }
    Ok(_) -> {
      // Rotate direction CW
      let direction = case direction {
        #(0, -1) -> #(1, 0)
        #(1, 0) -> #(0, 1)
        #(0, 1) -> #(-1, 0)
        #(-1, 0) -> #(0, -1)
        _ -> panic as "This is unexpected"
      }

      step(grid, pos, direction, visited)
    }
    Error(_) -> {
      visited |> dict.values |> list.length
    }
  }
}

pub fn walk(input) {
  let items =
    input
    |> string.trim
    |> string.split("\n")
    |> list.map(string.split(_, ""))
    // |> list.filter(fn(line) { list.length(line) > 0 })
    |> list.index_map(fn(line, y) {
      list.index_map(line, fn(char, x) { #(#(x, y), char) })
    })
    |> list.flatten
  let grid = dict.from_list(items)

  let #(sx, xy) =
    dict.filter(grid, fn(_k, v) { v == "^" })
    |> dict.keys
    |> list.first
    |> result.unwrap(or: #(0, 0))

  let result = step(grid, #(sx, xy + 1), #(0, -1), dict.new())

  #(result, 0)
}
