import argv
import days/day_one
import days/day_two
import gleam/io

pub fn main() {
  case argv.load().arguments {
    ["day1", filename] -> day_one.print_result(filename)
    ["day2", filename] -> day_two.print_result(filename)
    _ -> io.println("Usage: vars day#")
  }
}
