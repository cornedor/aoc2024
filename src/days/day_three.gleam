import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/regexp
import gleam/string

fn do_mul(input: String) {
  let assert Ok(re) = regexp.from_string("mul\\(([0-9]{1,3}),([0-9]{1,3})\\)")
  let matches = regexp.scan(re, input)

  list.fold(matches, 0, fn(acc, match) {
    case match.submatches {
      [option.Some(a), option.Some(b)] ->
        acc
        + case int.parse(a), int.parse(b) {
          Ok(a), Ok(b) -> a * b
          _, _ -> 0
        }
      _ -> acc
    }
  })
}

pub fn compute(input: String) -> #(Int, Int) {
  let assert Ok(donts) = regexp.from_string("don't\\(\\).*$")

  let part1 = do_mul(input)

  let cleaned =
    string.replace(input, each: "\n", with: "")
    |> string.split(on: "do()")
    |> list.map(regexp.replace(donts, _, ""))
    |> string.join("do()")

  let part2 =
    cleaned
    |> do_mul

  #(part1, part2)
}
