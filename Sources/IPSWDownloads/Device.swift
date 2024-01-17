//
//  File.swift
//
//
//  Created by Leo Dion on 1/11/24.
//
import Foundation

public struct Device {
  public let name: String
  public let identifier: String
  public let firmwares: [Firmware]
  public let boards: [Board]

  public init(name: String, identifier: String, firmwares: [Firmware], boards: [Board]) {
    self.name = name
    self.identifier = identifier
    self.firmwares = firmwares
    self.boards = boards
  }
}

extension Device {
  internal init(component: Components.Schemas.Device) throws {
    try self.init(
      name: component.name,
      identifier: component.identifier,
      firmwares: component.firmwares.map(Firmware.init(component:)),
      boards: component.boards.map(Board.init(component:))
    )
  }
}
