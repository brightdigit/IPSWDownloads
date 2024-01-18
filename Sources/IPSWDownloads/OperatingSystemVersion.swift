import Foundation

extension OperatingSystemVersion {
  internal init(string: String) throws {
    let components = string.components(separatedBy: ".").compactMap(Int.init)

    guard components.count == 2 || components.count == 3 else {
      throw RuntimeError.invalidVersion(string)
    }

    self.init(
      majorVersion: components[0],
      minorVersion: components[1],
      patchVersion: components.count == 3 ? components[2] : 0
    )
  }
}
