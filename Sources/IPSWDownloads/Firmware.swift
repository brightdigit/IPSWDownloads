//
//  Firmware.swift
//  IPSWDownloads
//
//  Created by Leo Dion.
//  Copyright © 2024 BrightDigit.
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
import OperatingSystemVersion

/// A struct representing firmware details of a device.
public struct Firmware: Sendable, Codable, Hashable, Equatable {
  /// The unique identifier of the firmware.
  public let identifier: String

  /// The version of the operating system associated with the firmware.
  public let version: OperatingSystemVersion

  /// The build ID of the firmware.
  public let buildid: String

  /// The SHA-1 checksum of the firmware.
  public let sha1sum: Data?

  /// The MD5 checksum of the firmware.
  public let md5sum: Data?

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
    sha1sum: Data?,
    md5sum: Data?,
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
  /// Initializes a new Firmware instance
  /// from a given `Components.Schemas.Firmware` component.
  ///
  /// - Parameter component: The component containing firmware details.
  /// - Throws: An error if there is an issue initializing the firmware.
  internal init(component: Components.Schemas.Firmware) throws {
    try self.init(
      identifier: component.identifier,
      version: OperatingSystemVersion(string: component.version),
      buildid: component.buildid,
      sha1sum: Data(hexString: component.sha1sum, emptyIsNil: true),
      md5sum: Data(hexString: component.md5sum, emptyIsNil: true),
      filesize: component.filesize,
      url: URL(validatingURL: component.url),
      releasedate: component.releasedate,
      uploaddate: component.uploaddate,
      signed: component.signed
    )
  }
}
