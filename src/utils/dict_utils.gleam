import gleam/dict
import gleam/list

pub fn index_of(dictionary, value) {
  dict.filter(dictionary, fn(_k, v) { v == value })
  |> dict.keys
  |> list.first
}
