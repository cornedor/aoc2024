import gleam/io
import simplifile

pub fn read(path: String) -> String {
  case simplifile.read(from: path) {
    Ok(x) -> x
    Error(_) -> {
      io.println("Could not read file")
      panic as "Could not read file"
    }
  }
}
