import IPSWDownloads
import OpenAPIURLSession
import XCTest

final class IPSWDownloadsTest: XCTestCase {
  var client: IPSWDownloads!

  override func setUp() {
    assert(client == nil)
    client = IPSWDownloads(transport: URLSessionTransport())
  }

  func testExample() async throws {
    let device = try await client.device(withIdentifier: "VirtualMac2,1", type: .ipsw)
    XCTAssertEqual(device.identifier, "VirtualMac2,1")
    XCTAssertGreaterThan(device.firmwares.count, 10)
    XCTAssertNotNil(device.firmwares.first)
  }
}
