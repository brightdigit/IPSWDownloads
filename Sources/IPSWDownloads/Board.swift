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
  public let cpid: Int
  public let bdid: Int

  public init(boardconfig: String, platform: String, cpid: Int, bdid: Int) {
    self.boardconfig = boardconfig
    self.platform = platform
    self.cpid = cpid
    self.bdid = bdid
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
