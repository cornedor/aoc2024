import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

pub fn parse_input(input: String) {
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

pub fn compare(filename: String) -> Nil {
  let _ = io.debug("Time to compare!")

  let x = case simplifile.read(from: filename) {
    Ok(x) -> x
    Error(_) -> {
      io.println("Could not read file")
      panic as "Could not read file"
    }
  }

  let #(list_a, list_b) = parse_input(x)
  io.debug([list_a, list_b])
  let #(sorted_a, sorted_b) = #(
    list.sort(list_a, by: int.compare),
    list.sort(list_b, int.compare),
  )

  let total_diff =
    list.zip(sorted_a, sorted_b)
    |> list.map(fn(vals) { int.subtract(vals.0, vals.1) |> int.absolute_value })
    |> list.fold(0, int.add)

  io.println("Part 1: " <> int.to_string(total_diff))

  let part_2 =
    list.fold(list_a, 0, fn(acc, x) {
      let counted = list.count(list_b, fn(y) { x == y })
      x * counted + acc
    })

  io.println("Part 2: " <> int.to_string(part_2))

  Nil
}
