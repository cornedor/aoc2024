import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/order
import gleam/result
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

  let part_2 =
    list.fold(pages, 0, fn(acc, page) {
      let values = dict.values(page)
      let sorted =
        list.sort(values, fn(a, b) {
          let lt = list.contains(instructions, #(a, b))
          let gt = list.contains(instructions, #(b, a))

          case lt, gt {
            True, _ -> order.Lt
            _, True -> order.Gt
            _, _ -> order.Eq
          }
        })

      case values == sorted {
        True -> acc
        False -> {
          let mid = { list.length(values) - 1 } / 2
          let mid = list.drop(sorted, mid) |> list.first |> result.unwrap(0)
          acc + mid
        }
      }
    })

  #(part_1, part_2)
}
