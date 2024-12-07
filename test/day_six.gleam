import days/day_six
import glacier/should

pub fn day_six_test() {
  day_six.walk(
    "
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
",
  )
  |> should.equal(#(41, 0))
}