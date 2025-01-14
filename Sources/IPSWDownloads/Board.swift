//
//  Board.swift
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

/// A struct representing a board with configuration details.
public struct Board: Sendable, Codable, Hashable, Equatable {
  /// The configuration of the board.
  public let boardconfig: String

  /// The platform information of the board.
  public let platform: String

  /// The CHIP tag is a 16-bit unsigned integer that denotes the type of chip
  /// the firmware is to be installed to. It is one of the few tags that is not
  /// read from the fuses but is instead hardcoded in the bootchain. It is used
  /// to prevent incompatible firmwares from being installed; different processors
  /// may have their MMIO registers in different locations.
  public let cpid: Int

  /// The Board ID of a device (also known as BORD, BDID, or ApBoardId) is a value
  /// (usually represented as `uint8_t`) that represents multiple characteristics
  /// of the logic board.
  public let bdid: Int

  /// Initializes a new Board instance with the provided parameters.
  ///
  /// - Parameters:
  ///   - boardconfig: The configuration of the board.
  ///   - platform: The platform information of the board.
  ///   - cpid: The CHIP tag representing the type of chip for firmware installation.
  ///   - bdid: The Board ID of the device
  ///   representing characteristics of the logic board.
  public init(boardconfig: String, platform: String, cpid: Int, bdid: Int) {
    self.boardconfig = boardconfig
    self.platform = platform
    self.cpid = cpid
    self.bdid = bdid
  }
}

extension Board {
  /// Initializes a new Board instance from a given `Components.Schemas.Board` component.
  ///
  /// - Parameter component: The component containing board details.
  internal init(component: Components.Schemas.Board) {
    self.init(
      boardconfig: component.boardconfig,
      platform: component.platform,
      cpid: component.cpid,
      bdid: component.bdid
    )
  }
}
