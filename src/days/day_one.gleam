import gleam/int
import gleam/io
import gleam/list
import gleam/string

import utils/input_file

fn parse_input(input: String) {
  input
  |> string.trim()
  |> string.split("\n")
  |> list.map(string.split(_, "   "))
  |> list.map(list.map(_, fn(ch) {
    case int.parse(ch) {
      Ok(x) -> x
      Error(_) -> panic as "Incorrect input"
    }
  }))
  |> list.map(fn(parts) {
    let _ = case parts {
      [a, b, ..] -> #(a, b)
      _ -> panic as "Incorrect input"
    }
  })
  |> list.unzip
}

pub fn compare_string(input: String) {
  let #(list_a, list_b) = parse_input(input)

  let #(sorted_a, sorted_b) = #(
    list.sort(list_a, by: int.compare),
    list.sort(list_b, int.compare),
  )

  let result_one =
    list.zip(sorted_a, sorted_b)
    |> list.map(fn(vals) { int.subtract(vals.0, vals.1) |> int.absolute_value })
    |> list.fold(0, int.add)

  let result_two =
    list.fold(list_a, 0, fn(acc, x) {
      let counted = list.count(list_b, fn(y) { x == y })
      x * counted + acc
    })

  #(result_one, result_two)
}

pub fn compare(path: String) {
  compare_string(input_file.read(path))
}

pub fn print_result(path: String) -> Nil {
  let #(result_one, result_two) = compare(path)

  io.println("Part 1: " <> int.to_string(result_one))
  io.println("Part 2: " <> int.to_string(result_two))
}
