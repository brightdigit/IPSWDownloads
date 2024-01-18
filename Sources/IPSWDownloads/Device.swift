//
//  File.swift
//
//  Created by Leo Dion on 1/11/24.
//

import Foundation

/// A struct representing an Apple device along with its firmware and supported boards.
public struct Device {
  /// The name of the Apple device.
  public let name: String

  /// The unique identifier of the Apple device.
  public let identifier: String

  /// The list of firmware versions supported by the device.
  public let firmwares: [Firmware]

  /// The list of boards supported by the device.
  public let boards: [Board]

  /// Initializes a new Device instance with the provided parameters.
  ///
  /// - Parameters:
  ///   - name: The name of the Apple device.
  ///   - identifier: The unique identifier of the Apple device.
  ///   - firmwares: The list of firmware versions supported by the device.
  ///   - boards: The list of boards supported by the device.
  public init(name: String, identifier: String, firmwares: [Firmware], boards: [Board]) {
    self.name = name
    self.identifier = identifier
    self.firmwares = firmwares
    self.boards = boards
  }
}

extension Device {
  /// Initializes a new Device instance from a given `Components.Schemas.Device` component.
  ///
  /// - Parameter component: The component containing device details.
  /// - Throws: An error if there is an issue initializing the device.
  internal init(component: Components.Schemas.Device) throws {
    try self.init(
      name: component.name,
      identifier: component.identifier,
      firmwares: component.firmwares.map(Firmware.init(component:)),
      boards: component.boards.map(Board.init(component:))
    )
  }
}
