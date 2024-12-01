import argv
import days/day_one
import gleam/io

pub fn main() {
  case argv.load().arguments {
    ["day1", filename] -> day_one.print_result(filename)
    _ -> io.println("Usage: vars day#")
  }
}
