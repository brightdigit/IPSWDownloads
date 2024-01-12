//
//  File.swift
//  
//
//  Created by Leo Dion on 1/11/24.
//
import OpenAPIRuntime
import Foundation

enum FirmwareType : String {
  case ipsw
  case ota
}

/// A hand-written Swift API for the greeting service, one that doesn't leak any generated code.
public struct IPSWDownloads {
  
  public static let serverURL = try! Servers.server1()

    /// The underlying generated client to make HTTP requests to GreetingService.
    private let underlyingClient: any APIProtocol
//
    /// An internal initializer used by other initializers and by tests.
    /// - Parameter underlyingClient: The client to use to make HTTP requests.
    private init(underlyingClient: any APIProtocol) { self.underlyingClient = underlyingClient }
//
//    /// Creates a new client for GreetingService.
  public init(serverURL: URL = Self.serverURL, transport: any ClientTransport) {
        self.init(
            underlyingClient: Client(
                serverURL: serverURL,
                transport: transport
            )
        )
    }
  
  func firmwaresForDevice(withIdentifier identifier: String, type: FirmwareType) async throws {
    let input = Operations.firmwaresForDevice.Input(
      path: .init(identifier: identifier),
      query: .init(_type: type.rawValue)
    )
    let firmwares = try await self.underlyingClient.firmwaresForDevice(input)
    //self.underlyingClient.firmwaresForDevice(Operations.firmwaresForDevice.Input)
  }
//
//    /// Fetches the customized greeting for the provided name.
//    /// - Parameter name: The name for which to provide a greeting, or nil to get a default.
//    /// - Returns: A customized greeting message.
//    /// - Throws: An error if the underlying HTTP client fails.
//    public func getGreeting(name: String?) async throws -> String {
//        let response = try await underlyingClient.getGreeting(query: .init(name: name))
//        return try response.ok.body.json.message
//    }
}
