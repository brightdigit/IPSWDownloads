//
// MainApp.swift
// Copyright (c) 2023 BrightDigit.
//

import OpenAPIURLSession

@main
enum MainApp {
  static func main() async throws {
    let client = try Client(serverURL: Servers.server1(), transport: URLSessionTransport())
    let response = try await client.firmwaresForDevice(.init(path: .init(identifier: "VirtualMac2,1"), query: .init(_type: "ipsw")))
    guard let ipswFiles = try response.ok.body.json.firmwares else {
      return
    }
    let result = try await withThrowingTaskGroup(of: Components.Schemas.Firmware?.self) { group in
      for ipswFile in ipswFiles {
        group.addTask {
          try await client.ipswByIdentifierAndBuild(.init(path: .init(identifier: "VirtualMac2,1", buildid: ipswFile.buildid))).ok.body.json
        }
      }

      return try await group.compactMap { $0 }.reduce(into: [Components.Schemas.Firmware]()) { partialResult, item in
        partialResult.append(item)
      }
    }

    dump(result)
  }
}
