//
//  DataTest.swift
//  IPSWDownloads
//
//  Created by DataTest.swift
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

import Foundation
@testable import IPSWDownloads
import XCTest

extension String {
  static let validHexCharacters = "0123456789abcdefABCDEF"

  static func random(ofLength length: Int, validCharacters: String) -> String {
    guard !validCharacters.isEmpty else {
      return ""
    }

    var randomString = ""

    for _ in 0 ..< length {
      let randomIndex = Int.random(in: 0 ..< validCharacters.count)
      let character = validCharacters[validCharacters.index(validCharacters.startIndex, offsetBy: randomIndex)]
      randomString.append(character)
    }

    return randomString
  }
}

public class DataTests: XCTestCase {
  func testInitStringValid() throws {
    let validCount = Int.random(in: 20 ... 50)
    let values: [String] = (0 ..< validCount).map { _ in
      Int.random(in: 5 ... 25)
    }.map { length in
      .random(ofLength: length * 2, validCharacters: String.validHexCharacters)
    }

    for value in values {
      _ = try Data(hexString: value)
      try XCTAssertNotNil(Data(hexString: value, emptyIsNil: true))
      try XCTAssertNotNil(Data(hexString: value, emptyIsNil: false))
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
        _ = try Data(hexString: string)
      } catch let RuntimeError.invalidDataHexString(value) {
        actual = value
      }
      XCTAssertEqual(string, actual)
    }
  }
  
  func testInitStringEmpty() throws {
    try XCTAssertNil(Data(hexString: "", emptyIsNil: true))
  }
}
