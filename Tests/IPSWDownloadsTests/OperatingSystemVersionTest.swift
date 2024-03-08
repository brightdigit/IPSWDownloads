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

extension OperatingSystemVersion {
  static func random() -> OperatingSystemVersion {
    .init(
      majorVersion: .random(in: 1 ... 25),
      minorVersion: .random(in: 0 ... 25),
      patchVersion: Bool.random() ? .random(in: 1 ... 25) : 0
    )
  }
}

public class OperatingSystemVersionTests: XCTestCase {
  func testInitStringValid() throws {
    let validCount = Int.random(in: 20 ... 50)
    let values: [OperatingSystemVersion] = (0 ..< validCount).map { _ in
      .random()
    }
    for value in values {
      try XCTAssertEqual(value,
                         .init(string:
                           value.description))
      try XCTAssertEqual(value,
                         .init(string:
                           value.string(trimZeroPatch: false)))
      try XCTAssertEqual(value,
                         .init(string: value.string(trimZeroPatch: true)))
    }
  }

  func testInitIntComponents() throws {
    let validCount = Int.random(in: 20 ... 50)
    let values: [OperatingSystemVersion] = (0 ..< validCount).map { _ in
      .random()
    }

    for value in values {
      try XCTAssertEqual(
        .init(components: [value.majorVersion, value.minorVersion, value.patchVersion]), value
      )
      guard value.patchVersion == 0 else {
        continue
      }

      try XCTAssertEqual(
        .init(components: [value.majorVersion, value.minorVersion]), value
      )
    }
  }

  func testCompare() throws {
    let validCount = Int.random(in: 20 ... 50)
    let values: [OperatingSystemVersion] = (0 ..< validCount).map { _ in
      .random()
    }

    for value in values {
      let greaterThanMajor = OperatingSystemVersion(
        majorVersion: value.majorVersion + 1,
        minorVersion: value.minorVersion,
        patchVersion: value.patchVersion
      )
      let greaterThanMinor = OperatingSystemVersion(
        majorVersion: value.majorVersion,
        minorVersion: value.minorVersion + 1,
        patchVersion: value.patchVersion
      )
      let greaterThanPatch = OperatingSystemVersion(
        majorVersion: value.majorVersion,
        minorVersion: value.minorVersion,
        patchVersion: value.patchVersion + 1
      )
      let lessThanMajor = OperatingSystemVersion(
        majorVersion: value.majorVersion - 1,
        minorVersion: value.minorVersion,
        patchVersion: value.patchVersion
      )

      XCTAssertGreaterThan(greaterThanMajor, value)
      XCTAssertGreaterThan(greaterThanMinor, value)
      XCTAssertGreaterThan(greaterThanPatch, value)
      XCTAssertGreaterThan(value, lessThanMajor)

//      let lessThanMinor = OperatingSystemVersion(
//        majorVersion: value.majorVersion,
//        minorVersion: value.minorVersion - 1,
//        patchVersion: value.patchVersion
//      )
//      let lessThanPatch = OperatingSystemVersion(
//        majorVersion: value.majorVersion,
//        minorVersion: value.minorVersion,
//        patchVersion: value.patchVersion - 1
//      )
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
