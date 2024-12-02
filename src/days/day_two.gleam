import gleam/int
import gleam/io
import gleam/list
import gleam/string
import utils/input_file

fn parse_input(input: String) {
  string.trim(input)
  |> string.split("\n")
  |> list.map(string.split(_, " "))
  |> list.map(list.map(_, fn(ch) {
    case int.parse(ch) {
      Ok(x) -> x
      Error(_) -> panic as "Incorrect input"
    }
  }))
}

fn get_direction(a, b) {
  case a - b > 0 {
    True -> 1
    False -> 2
  }
}

fn is_valid(input: List(Int), direction: Int, index: Int) -> #(Bool, Int) {
  case input {
    [_] | [] -> #(True, index)
    [a, b, ..rest] -> {
      let direction = case direction {
        0 -> get_direction(a, b)
        _ -> direction
      }

      let diff = int.absolute_value(a - b)

      let is_in_range = diff >= 1 && diff <= 3
      let is_same_direction = direction == get_direction(a, b) || direction == 0

      case is_in_range && is_same_direction {
        False -> #(False, index)
        True -> is_valid([b, ..rest], direction, index + 1)
      }
    }
  }
}

fn fault_tollerant_check(input: List(Int), direction: Int) {
  case is_valid(input, direction, 0) {
    #(True, _) -> True
    #(False, index) -> {
      [
        remove_at_index(input, index + -1),
        remove_at_index(input, index),
        remove_at_index(input, index + 1),
      ]
      |> list.any(fn(x) { is_valid(x, direction, 0).0 })
    }
  }
}

pub fn remove_at_index(list: List(a), index: Int) -> List(a) {
  list.take(list, index)
  |> list.append(list.drop(list, index + 1))
}

pub fn check_levels_string(input: String) {
  let input = parse_input(input)

  let p2 = list.count(input, fn(line) { fault_tollerant_check(line, 0) })

  #(list.count(input, fn(line) { is_valid(line, 0, 0).0 }), p2)
}

fn check_levels(path: String) {
  check_levels_string(input_file.read(path))
}

pub fn print_result(path: String) -> Nil {
  let #(part_one, part_two) = check_levels(path)

  io.println("Part 1: " <> int.to_string(part_one))
  io.println("Part 2: " <> int.to_string(part_two))

  Nil
}
