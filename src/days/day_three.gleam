import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/regexp

pub fn compute(input: String) -> #(Int, Int) {
  let assert Ok(re) = regexp.from_string("mul\\(([0-9]{1,3}),([0-9]{1,3})\\)")

  let matches = regexp.scan(re, input)

  let part1 =
    list.fold(matches, 0, fn(acc, match) {
      io.debug(match.submatches)
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

  #(part1, 0)
}
