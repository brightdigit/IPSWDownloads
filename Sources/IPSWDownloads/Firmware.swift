//
//  File.swift
//
//  Created by Leo Dion on 1/11/24.
//

import Foundation

/// A struct representing firmware details of a device.
public struct Firmware {
  /// The unique identifier of the firmware.
  public let identifier: String

  /// The version of the operating system associated with the firmware.
  public let version: OperatingSystemVersion

  /// The build ID of the firmware.
  public let buildid: String

  /// The SHA-1 checksum of the firmware.
  public let sha1sum: String

  /// The MD5 checksum of the firmware.
  public let md5sum: String

  /// The size of the firmware file in bytes.
  public let filesize: Int

  /// The URL where the firmware can be downloaded.
  public let url: URL

  /// The release date of the firmware.
  public let releasedate: Date

  /// The upload date of the firmware.
  public let uploaddate: Date

  /// A flag indicating whether the firmware is signed.
  public let signed: Bool

  /// Initializes a new Firmware instance with the provided parameters.
  ///
  /// - Parameters:
  ///   - identifier: The unique identifier of the firmware.
  ///   - version: The version of the operating system associated with the firmware.
  ///   - buildid: The build ID of the firmware.
  ///   - sha1sum: The SHA-1 checksum of the firmware.
  ///   - md5sum: The MD5 checksum of the firmware.
  ///   - filesize: The size of the firmware file in bytes.
  ///   - url: The URL where the firmware can be downloaded.
  ///   - releasedate: The release date of the firmware.
  ///   - uploaddate: The upload date of the firmware.
  ///   - signed: A flag indicating whether the firmware is signed.
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
  /// Initializes a new Firmware instance from a given `Components.Schemas.Firmware` component.
  ///
  /// - Parameter component: The component containing firmware details.
  /// - Throws: An error if there is an issue initializing the firmware.
  internal init(component: Components.Schemas.Firmware) throws {
    try self.init(
      identifier: component.identifier,
      version: OperatingSystemVersion(string: component.version),
      buildid: component.buildid,
      sha1sum: component.sha1sum,
      md5sum: component.md
