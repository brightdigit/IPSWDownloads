//
//  File.swift
//
//
//  Created by Leo Dion on 1/11/24.
//
import Foundation
import OpenAPIRuntime

public struct IPSWDownloads {
  // swiftlint:disable:next force_try
  public static let serverURL = try! Servers.server1()

  /// The underlying generated client to make HTTP requests to GreetingService.
  private let underlyingClient: any APIProtocol
//
  /// An internal initializer used by other initializers and by tests.
  /// - Parameter underlyingClient: The client to use to make HTTP requests.
  private init(underlyingClient: any APIProtocol) {
    self.underlyingClient = underlyingClient
  }

  /// Creates a new client for GreetingService.
  public init(
    transport: any ClientTransport,
    serverURL: URL = Self.serverURL
  ) {
    self.init(
      underlyingClient: Client(
        serverURL: serverURL,
        transport: transport
      )
    )
  }

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
