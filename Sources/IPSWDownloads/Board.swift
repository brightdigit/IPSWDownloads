//
//  File.swift
//
//
//  Created by Leo Dion on 1/11/24.
//
import Foundation

public struct Board {
  public let boardconfig: String
  public let platform: String

  /// The CHIP tag is a 16-bit unsigned integer
  /// that denotes the type of chip the firmware is to be installed to.
  /// It is one of the few tags that is not read from the fuses,
  /// but is instead hardcoded in the bootchain.
  /// It is used to prevent incompatible firmwares from being installed;
  /// different processors may have their MMIO registers in different locations.
  public let cpid: Int

  /// The Board ID of a device
  /// (also known as BORD, BDID, or ApBoardId) is a value
  /// (usually represented as `uint8\_t`)
  /// hat represents multiple characteristics of the logic board
  public let bdid: Int

  public init(boardconfig: String, platform: String, cpid: Int, bdid: Int) {
    self.boardconfig = boardconfig
    self.platform = platform
    self.cpid = cpid
    self.bdid = bdid
  }
}

extension Board {
  internal init(component: Components.Schemas.Board) {
    self.init(
      boardconfig: component.boardconfig,
      platform: component.platform,
      cpid: component.cpid,
      bdid: component.bdid
    )
  }
}
