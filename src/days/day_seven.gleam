import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn try_math(answer, nums, ops) {
  let #(first, rest) = case nums {
    [first, ..rest] -> #(first, rest)
    _ -> #(0, [])
  }

  let max = int.bitwise_shift_left(1, list.length(rest)) - 1

  let x =
    list.index_fold(rest, first, fn(acc, x, index) {
      let step = int.bitwise_shift_left(1, index)
      case int.bitwise_and(ops, step) {
        0 -> acc + x
        _ -> acc * x
      }
    })

  case x, ops {
    a, _ if a == answer -> Ok(answer)
    _, x if x >= max -> Error(Nil)
    _, _ -> try_math(answer, nums, ops + 1)
  }
}

fn parse_input(input) {
  input
  |> string.trim
  |> string.split("\n")
  |> list.map(string.split(_, ":"))
  |> list.map(fn(x) {
    case x {
      [result, nums] -> {
        let result = int.parse(result) |> result.unwrap(0)
        #(
          result,
          nums
            |> string.trim
            |> string.split(" ")
            |> list.map(fn(n) { int.parse(n) |> result.unwrap(0) }),
        )
      }
      _ -> panic as "Incorrect input"
    }
  })
}

pub fn run(input) {
  let part_1 =
    parse_input(input)
    |> list.map(fn(x) {
      let #(answer, nums) = x
      try_math(answer, nums, 0)
    })
    |> list.fold(0, fn(acc, x) {
      case x {
        Ok(x) -> acc + x
        Error(Nil) -> acc
      }
    })

  #(part_1, 0)
}
