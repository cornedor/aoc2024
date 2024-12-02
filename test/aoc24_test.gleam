import days/day_one
import days/day_two
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  1
  |> should.equal(1)
}

pub fn day1_test() {
  day_one.compare_string(
    "3   4
4   3
2   5
1   3
3   9
3   3
",
  )
  |> should.equal(#(11, 31))
}

pub fn day2_test() {
  let input =
    "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"

  day_two.check_levels_string(input)
  |> should.equal(#(2))
}
