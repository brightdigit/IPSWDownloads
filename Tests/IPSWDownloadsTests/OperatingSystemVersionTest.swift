//
//  OperatingSystemVersionTest.swift
//  IPSWDownloads
//
//  Created by Leo Dion.
//  Copyright © 2024 BrightDigit.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the “Software”), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

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
    let invalidCount = Int.random(in: 20 ... 50)
    let strings: [String] = (0 ..< invalidCount).map { _ in
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
