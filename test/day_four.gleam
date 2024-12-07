import days/day_four
import glacier/should

pub fn day_four_test() {
  let input =
    "MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
"

  day_four.find_xmas(input)
  |> should.equal(#(18, 9))
}
