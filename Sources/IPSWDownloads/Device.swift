//
//  Device.swift
//  IPSWDownloads
//
//  Created by Leo Dion.
//  Copyright © 2025 BrightDigit.
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

/// A struct representing an Apple device along with its firmware and supported boards.
public struct Device: Sendable, Codable, Hashable, Equatable {
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
  /// Initializes a new Device instance
  /// from a given `Components.Schemas.Device` component.
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
