import argv
import days/day_one
import days/day_three
import days/day_two
import gleam/int
import gleam/io
import utils/input_file

fn print_result(filename: String, func: fn(String) -> #(Int, Int)) {
  let input = input_file.read(filename)
  let #(result_one, result_two) = func(input)

  io.println("Part 1: " <> int.to_string(result_one))
  io.println("Part 2: " <> int.to_string(result_two))
}

pub fn main() {
  case argv.load().arguments {
    ["day1", filename] -> print_result(filename, day_one.compare)
    ["day2", filename] -> print_result(filename, day_two.check_levels)
    ["day3", filename] -> print_result(filename, day_three.compute)
    _ -> io.println("Usage: vars day#")
  }
}
