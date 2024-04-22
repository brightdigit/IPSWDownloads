//
//  IPSWDownloads.swift
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

public import Foundation
public import OpenAPIRuntime

/// Client for downloading current and previous versions
/// of Apple's iOS Firmware, iTunes and OTA updates.
public struct IPSWDownloads: Sendable {
  // swiftlint:disable:next force_try
  private static let serverURL = try! Servers.Server1.url()

  /// The underlying generated client to make HTTP requests to IPSWDownloads.
  private let underlyingClient: any APIProtocol

  /// An internal initializer used by other initializers and by tests.
  /// - Parameter underlyingClient: The client to use to make HTTP requests.
  private init(underlyingClient: any APIProtocol) {
    self.underlyingClient = underlyingClient
  }

  /// Creates a new client for IPSWDownloads.
  ///
  /// - Parameters:
  ///   - transport: Client transport for connecting to the server.
  ///   - serverURL: Optional server url otherwise the default url is used.
  public init(
    transport: any ClientTransport,
    serverURL: URL? = nil
  ) {
    self.init(
      underlyingClient: Client(
        serverURL: serverURL ?? Self.serverURL,
        transport: transport
      )
    )
  }

  /// Returns Firmwares for a given Device.
  /// - Parameters:
  ///   - identifier: Device Identifier
  ///   - type: Specifies the type of Firmware files
  /// - Returns: Device object containing the list of firmware object.
  public func device(
    withIdentifier identifier: String,
    type: FirmwareType
  ) async throws -> Device {
    let input = Operations.getDevice.Input(
      path: .init(identifier: identifier),
      query: .init(_type: type.rawValue)
    )
    let device = try await underlyingClient.getDevice(input).ok.body.json
    return try Device(component: device)
  }
}
