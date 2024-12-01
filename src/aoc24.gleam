import argv
import days/one/compare_lists
import gleam/io

pub fn main() {
  case argv.load().arguments {
    ["day1", filename] -> compare_lists.compare(filename)
    _ -> io.println("Usage: vars day#")
  }
}
