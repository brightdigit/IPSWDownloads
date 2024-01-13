//
//  File.swift
//
//
//  Created by Leo Dion on 1/11/24.
//
import Foundation
import OpenAPIRuntime

public enum FirmwareType: String {
  case ipsw
  case ota
}

enum RuntimeError: Error {
  case invalidURL(String)
}

extension URL {
  /// Returns a validated server URL, or throws an error.
  /// - Parameter string: A URL string.
  /// - Throws: If the provided string doesn't convert to URL.
  public init(validatingURL string: String) throws {
    guard let url = Self(string: string) else { throw RuntimeError.invalidURL(string) }
    self = url
  }
}

public struct Firmware {
  public init(identifier: String, version: String, buildid: String, sha1sum: String, md5sum: String, filesize: Int, url: URL, releasedate: Date, uploaddate: Date, signed: Bool) {
    self.identifier = identifier
    self.version = version
    self.buildid = buildid
    self.sha1sum = sha1sum
    self.md5sum = md5sum
    self.filesize = filesize
    self.url = url
    self.releasedate = releasedate
    self.uploaddate = uploaddate
    self.signed = signed
  }

  public let identifier: String
  public let version: String
  public let buildid: String
  public let sha1sum: String
  public let md5sum: String
  public let filesize: Int
  public let url: URL
  public let releasedate: Date
  public let uploaddate: Date
  public let signed: Bool
}

public struct Board {
  public init(boardconfig: String, platform: String, cpid: Int, bdid: Int) {
    self.boardconfig = boardconfig
    self.platform = platform
    self.cpid = cpid
    self.bdid = bdid
  }

  public var boardconfig: String
  public var platform: String
  public var cpid: Int
  public var bdid: Int
}

public struct Device {
  public init(name: String, identifier: String, firmwares: [Firmware], boards: [Board]) {
    self.name = name
    self.identifier = identifier
    self.firmwares = firmwares
    self.boards = boards
  }

  public var name: String
  public var identifier: String
  public var firmwares: [Firmware]
  public var boards: [Board]
}

extension Firmware {
  init(component: Components.Schemas.Firmware) throws {
    try self.init(
      identifier: component.identifier,
      version: component.version,
      buildid: component.buildid,
      sha1sum: component.sha1sum,
      md5sum: component.md5sum,
      filesize: component.filesize,
      url: URL(validatingURL: component.url),
      releasedate: component.releasedate,
      uploaddate: component.uploaddate,
      signed: component.signed
    )
  }
}

extension Board {
  init(component: Components.Schemas.Board) {
    self.init(
      boardconfig: component.boardconfig,
      platform: component.platform,
      cpid: component.cpid,
      bdid: component.bdid
    )
  }
}

extension Device {
  init(component: Components.Schemas.Device) throws {
    try self.init(
      name: component.name,
      identifier: component.identifier,
      firmwares: component.firmwares.map(Firmware.init(component:)),
      boards: component.boards.map(Board.init(component:))
    )
  }
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

  func device(withIdentifier identifier: String, type: FirmwareType) async throws -> Device {
    let input = Operations.firmwaresForDevice.Input(
      path: .init(identifier: identifier),
      query: .init(_type: type.rawValue)
    )
    let device = try await underlyingClient.firmwaresForDevice(input).ok.body.json
    return try Device(component: device)
  }

}
