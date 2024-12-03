import days/day_two
import glacier/should

pub fn day_two_test() {
  let input =
    "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"

  day_two.remove_at_index([1, 2, 3, 4, 5], 2)
  |> should.equal([1, 2, 4, 5])
  day_two.remove_at_index([1, 2, 3, 4, 5], -1)
  |> should.equal([1, 2, 3, 4, 5])

  day_two.check_levels(input)
  |> should.equal(#(2, 4))
}
