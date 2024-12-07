import glacier
import glacier/should
import gleam/dict
import utils/dict_utils

pub fn main() {
  glacier.main()
}

pub fn dict_utils_test() {
  dict_utils.index_of(dict.from_list([#(1, "a"), #(2, "b"), #(3, "c")]), "b")
  |> should.equal(Ok(2))
}
