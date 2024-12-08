import gleam/dict
import gleam/list
import gleam/otp/task
import gleam/result
import gleam/string

pub type Direction {
  Up
  Down
  Left
  Right
}

fn direction_to_offset(direction: Direction) -> #(Int, Int) {
  case direction {
    Up -> #(0, -1)
    Down -> #(0, 1)
    Left -> #(-1, 0)
    Right -> #(1, 0)
  }
}

fn step(grid, pos: #(Int, Int), direction: Direction, visited) {
  let #(x, y) = pos
  let #(dx, dy) = direction_to_offset(direction)

  let new_x = x + dx
  let new_y = y + dy

  case dict.get(grid, #(new_x, new_y)), dict.get(visited, #(new_x, new_y)) {
    Error(_), _ -> {
      #(visited |> dict.values |> list.length, visited)
    }
    Ok(_), Ok(vdir) if vdir == direction -> {
      // Already visited, we're in a loop
      #(-1, visited)
    }
    Ok(char), _ if char == "#" -> {
      // Rotate direction CW
      let direction = case direction {
        Up -> Right
        Right -> Down
        Down -> Left
        Left -> Up
      }

      step(grid, pos, direction, visited)
    }
    Ok(_), _ -> {
      let visited = dict.insert(visited, #(new_x, new_y), direction)
      step(grid, #(new_x, new_y), direction, visited)
    }
  }
}

pub fn walk(input) {
  let items =
    input
    |> string.trim
    |> string.split("\n")
    |> list.map(string.split(_, ""))
    |> list.index_map(fn(line, y) {
      list.index_map(line, fn(char, x) { #(#(x, y), char) })
    })
    |> list.flatten
  let grid = dict.from_list(items)

  let #(sx, sy) =
    dict.filter(grid, fn(_k, v) { v == "^" })
    |> dict.keys
    |> list.first
    |> result.unwrap(or: #(0, 0))

  let #(part_1, visited) = step(grid, #(sx, sy + 1), Up, dict.new())
  // The result of part 1 can be resused to uptimize part 2

  let x =
    visited
    |> dict.delete(#(sx, sy))
    |> dict.keys
    |> list.map(fn(block) {
      task.async(fn() {
        let grid = dict.insert(grid, block, "#")
        step(grid, #(sx, sy + 1), Up, dict.new())
      })
    })
    |> list.map(task.await_forever)
    |> list.filter(fn(r) {
      let #(v, _) = r
      v == -1
    })
    |> list.length

  #(part_1, x)
}
