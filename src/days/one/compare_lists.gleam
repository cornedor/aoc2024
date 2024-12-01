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

  // io.println(parseInput(x))
  let #(a, b) = parse_input(x)
  let #(a, b) = #(list.sort(a, by: int.compare), list.sort(b, int.compare))

  io.debug(
    list.zip(a, b)
    |> list.map(fn(vals) { int.subtract(vals.0, vals.1) |> int.absolute_value })
    |> list.fold(0, int.add),
  )

  Nil
}
