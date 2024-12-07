import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import utils/dict_utils

fn parse_int_or_panic(input: String) {
  case int.parse(input) {
    Ok(x) -> x
    Error(_) -> {
      io.debug(input)
      panic as "Incorrect input"
    }
  }
}

pub fn check_pages(input) {
  let assert [instructions, pages] = string.split(input, "\n\n")

  let instructions =
    string.split(instructions, "\n")
    |> list.map(fn(line) {
      string.split(line, "|")
      |> list.map(parse_int_or_panic)
    })
    |> list.map(fn(x) {
      case x {
        [a, b] -> #(a, b)
        _ -> panic as "Incorrect input"
      }
    })

  let pages =
    string.trim(pages)
    |> string.split("\n")
    |> list.map(fn(line) {
      string.split(line, ",")
      |> list.index_map(fn(char, index) { #(index, parse_int_or_panic(char)) })
      |> dict.from_list
    })

  let correct =
    pages
    |> list.filter(fn(page) {
      list.all(instructions, fn(instruction) {
        let #(a, b) = instruction

        let index_a = dict_utils.index_of(page, a)
        let index_b = dict_utils.index_of(page, b)

        case index_a, index_b {
          Ok(a), Ok(b) if a > b -> False
          _, _ -> True
        }
      })
    })

  // 61 53 29
  let _ =
    list.map(correct, fn(page) {
      dict.values(page)
      |> list.map(int.to_string)
      |> string.join(",")
      |> io.debug
    })

  let part_1 =
    list.map(correct, fn(page) {
      let values = dict.values(page)
      let mid = { list.length(values) - 1 } / 2
      case dict.get(page, mid) {
        Ok(x) -> x
        Error(_) -> panic as "This is unexpected"
      }
    })
    |> list.fold(0, fn(acc, x) { acc + x })

  #(part_1, 0)
}
