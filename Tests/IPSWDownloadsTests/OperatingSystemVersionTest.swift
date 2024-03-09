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

  func jsonStringText() -> String {
    """
    {
      "majorVersion" : \(majorVersion),
      "minorVersion" : \(minorVersion),
      "patchVersion" : \(patchVersion),
    }
    """
  }

  func jsonString(using encoding: String.Encoding = .utf8) -> Data? {
    jsonStringText().data(using: encoding)
  }

  func semverString(trimZeroPatch: Bool, using _: String.Encoding = .utf8) -> Data? {
    let description = string(trimZeroPatch: trimZeroPatch)
    return "\"\(description)\"".data(using: .utf8)
  }

  func intArrayString(trimZeroPatch: Bool, using encoding: String.Encoding = .utf8) -> Data? {
    let values: [Int] = [
      majorVersion,
      minorVersion,
      (!trimZeroPatch || patchVersion > 0) ? patchVersion : nil
    ].compactMap { $0 }
    let listString: String = values.map(\.description).joined(separator: ",")
    return "[\(listString)]".data(using: encoding)
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

  func testInitIntFailure() throws {
    let invalidCount = Int.random(in: 20 ... 50)
    let componentSets: [[Int]] = (0 ..< invalidCount).map { _ in
      let value = Int.random(in: 2 ... 10)
      let count = value <= 3 ? value - 2 : value
      return (0 ..< count).map { _ in
        .random(in: 0 ... 100)
      }
    }

    for components in componentSets {
      XCTAssertThrowsError(try OperatingSystemVersion(components: components)) { error in
        let error = error as? OperatingSystemVersion.Error
        let count: Int? = if case let .invalidComponentsCount(value) = error {
          value
        } else {
          nil
        }
        XCTAssertEqual(count, components.count)
      }
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

  func testHashable() {
    let validCount = Int.random(in: 20 ... 50)
    let values: [OperatingSystemVersion] = (0 ..< validCount).map { _ in
      .random()
    }
    for value in values {
      XCTAssertNotNil(value.hashValue)
    }
  }

  func testDecoding() throws {
    let validCount = Int.random(in: 20 ... 50)
    let values: [OperatingSystemVersion] = (0 ..< validCount).map { _ in
      .random()
    }
    let decoder = JSONDecoder()
    for value in values {
      XCTAssertEqual(
        value,
        try decoder.decodeVersion(value, with: { $0.jsonString(using: $1) })
      )
      XCTAssertEqual(
        value,
        try decoder.decodeVersion(value, with: { $0.intArrayString(trimZeroPatch: false, using: $1) })
      )
      XCTAssertEqual(
        value,
        try decoder.decodeVersion(value, with: { $0.intArrayString(trimZeroPatch: true, using: $1) })
      )
      XCTAssertEqual(
        value,
        try decoder.decodeVersion(value, with: { $0.semverString(trimZeroPatch: false, using: $1) })
      )
      XCTAssertEqual(
        value,
        try decoder.decodeVersion(value, with: { $0.semverString(trimZeroPatch: true, using: $1) })
      )
    }
  }

  func testEncoder() throws {
    let encoder = JSONEncoder()

    let validCount = Int.random(in: 20 ... 50)
    let values: [OperatingSystemVersion] = (0 ..< validCount).map { _ in
      .random()
    }
    for value in values {
      try XCTAssertEqual("\"\(value.description)\"", encoder.encodeVersion(value))
    }
  }
}

extension JSONEncoder {
  func encodeVersion(
    _ version: OperatingSystemVersion
  ) throws -> String? {
    let data = try encode(version)
    return String(data: data, encoding: .utf8)
  }
}

extension JSONDecoder {
  func decodeVersion(
    _ version: OperatingSystemVersion,
    using encoding: String.Encoding = .utf8,
    with closure: @escaping (OperatingSystemVersion, String.Encoding) -> Data?
  ) throws -> OperatingSystemVersion? {
    let data = closure(version, encoding)
    return try data.map {
      try self.decode(OperatingSystemVersion.self, from: $0)
    }
  }
}
