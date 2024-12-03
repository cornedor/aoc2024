import days/day_one
import glacier/should

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
