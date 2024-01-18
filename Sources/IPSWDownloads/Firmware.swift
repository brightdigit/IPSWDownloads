//
//  File.swift
//
//
//  Created by Leo Dion on 1/11/24.
//
import Foundation

public struct Firmware {
  public let identifier: String
  public let version: OperatingSystemVersion
  public let buildid: String
  public let sha1sum: String
  public let md5sum: String
  public let filesize: Int
  public let url: URL
  public let releasedate: Date
  public let uploaddate: Date
  public let signed: Bool

  public init(
    identifier: String,
    version: OperatingSystemVersion,
    buildid: String,
    sha1sum: String,
    md5sum: String,
    filesize: Int,
    url: URL,
    releasedate: Date,
    uploaddate: Date,
    signed: Bool
  ) {
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
}

extension Firmware {
  internal init(component: Components.Schemas.Firmware) throws {
    try self.init(
      identifier: component.identifier,
      version: OperatingSystemVersion(string: component.version),
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
