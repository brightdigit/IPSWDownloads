@testable import IPSWDownloads
import XCTest

extension OperatingSystemVersion: Equatable {
  public static func == (lhs: OperatingSystemVersion, rhs: OperatingSystemVersion) -> Bool {
    lhs.majorVersion == rhs.majorVersion &&
      lhs.minorVersion == rhs.minorVersion &&
      lhs.patchVersion == rhs.patchVersion
  }

  static func random() -> OperatingSystemVersion {
    .init(
      majorVersion: .random(in: 1 ... 25),
      minorVersion: .random(in: 0 ... 25),
      patchVersion: Bool.random() ? .random(in: 1 ... 25) : 0
    )
  }

  func string(trimZeroPatch: Bool) -> String {
    let values: [Int?] = [
      majorVersion,
      minorVersion,
      (!trimZeroPatch || patchVersion > 0) ? patchVersion : nil
    ]
    return values.compactMap {
      $0?.description
    }.joined(separator: ".")
  }

  func parsed(trimZeroPatch: Bool) throws -> OperatingSystemVersion {
    try .init(string: string(trimZeroPatch: trimZeroPatch))
  }
}

public class OperatingSystemVersionTests: XCTestCase {
  func testInitStringValid() throws {
    let validCount = Int.random(in: 20 ... 50)
    let values: [OperatingSystemVersion] = (0 ..< validCount).map { _ in
      .random()
    }
    for value in values {
      try XCTAssertEqual(value, value.parsed(trimZeroPatch: false))
      try XCTAssertEqual(value, value.parsed(trimZeroPatch: true))
    }
  }

  func testInitStringInvalid() throws {
    let validCount = Int.random(in: 20 ... 50)
    let strings: [String] = (0 ..< validCount).map { _ in
      UUID().uuidString
    }
    for string in strings {
      var actual: String?
      do {
        _ = try OperatingSystemVersion(string: string)
      } catch let RuntimeError.invalidVersion(value) {
        actual = value
      }
      XCTAssertEqual(string, actual)
    }
  }
}
