import days/day_one
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
