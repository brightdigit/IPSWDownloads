//
//  File.swift
//
//
//  Created by Leo Dion on 1/11/24.
//
import Foundation
import OpenAPIRuntime

/// Client for downloading current and previous versions
/// of Apple's iOS Firmware, iTunes and OTA updates.
public struct IPSWDownloads {
  // swiftlint:disable:next force_try
  private static let serverURL = try! Servers.server1()

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
