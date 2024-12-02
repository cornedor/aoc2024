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

fn is_valid(input: List(Int), direction: Int) {
  case input {
    [_] | [] -> True
    [a, b, ..rest] -> {
      let direction = case direction {
        0 -> get_direction(a, b)
        _ -> direction
      }

      let diff = int.absolute_value(a - b)

      let is_in_range = diff >= 1 && diff <= 3
      let is_same_direction = direction == get_direction(a, b) || direction == 0

      case is_in_range && is_same_direction {
        False -> False
        True -> is_valid([b, ..rest], direction)
      }
    }
  }
}

pub fn check_levels_string(input: String) {
  let input = parse_input(input)

  #(list.count(input, is_valid(_, 0)))
}

fn check_levels(path: String) {
  check_levels_string(input_file.read(path))
}

pub fn print_result(path: String) -> Nil {
  let #(part_one) = check_levels(path)

  io.println("Part 1: " <> int.to_string(part_one))

  Nil
}
