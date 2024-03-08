//
//  IPSWDownloadsTest.swift
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

import IPSWDownloads
import OpenAPIURLSession
import XCTest

final class IPSWDownloadsTest: XCTestCase {
  var client: IPSWDownloads!

  override func setUp() {
    assert(client == nil)
    client = IPSWDownloads(transport: URLSessionTransport())
  }

  func testDeviceWithIdentifier() async throws {
    let device = try await client.device(withIdentifier: "VirtualMac2,1", type: .ipsw)
    XCTAssertEqual(device.identifier, "VirtualMac2,1")
    XCTAssertGreaterThan(device.firmwares.count, 10)
    XCTAssertNotNil(device.firmwares.first)
  }
}
