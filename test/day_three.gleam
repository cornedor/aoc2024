import days/day_three
import glacier/should

pub fn day_three_test() {
  let input =
    "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

  day_three.compute(input)
  |> should.equal(#(161, 161))
  let input =
    "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

  day_three.compute(input)
  |> should.equal(#(161, 48))
}
