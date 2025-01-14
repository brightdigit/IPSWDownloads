//
//  SemVer.swift
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

public struct SemVer: Hashable, Codable, Sendable {
  private enum CodingKeys: String, CodingKey {
    case major
    case minor
    case patch
    case prerelease
    case buildMetadata
  }

  // MARK: - String Parsing

  public enum ParsingError: Error {
    case invalidFormat
    case invalidNumbers
  }

  // MARK: - Encoding Configuration

  public enum EncodingFormat: String, Codable {
    case string
    case object
  }

  // swiftlint:disable:next force_unwrapping line_length
  public static let encodingFormatKey = CodingUserInfoKey(rawValue: "Semver.encodingFormat")!

  public let major: Int
  public let minor: Int
  public let patch: Int
  public let prerelease: String?
  public let buildMetadata: String?

  public init(
    major: Int,
    minor: Int,
    patch: Int = 0,
    prerelease: String? = nil,
    buildMetadata: String? = nil
  ) {
    self.major = major
    self.minor = minor
    self.patch = patch
    self.prerelease = prerelease
    self.buildMetadata = buildMetadata
  }

  // swiftlint:disable:next function_body_length
  public init(string: String) throws {
    let components = string.split(separator: "-", maxSplits: 1)
    let versionCore = components[0]
    let prereleaseAndBuild = components.count > 1 ? String(components[1]) : nil

    let numbers = versionCore.split(separator: ".")
    guard numbers.count >= 2 else {
      throw ParsingError.invalidFormat
    }

    guard
      let major = Int(numbers[0]),
      let minor = Int(numbers[1]) else {
      throw ParsingError.invalidNumbers
    }

    let patch = numbers.count > 2 ? Int(numbers[2]) ?? 0 : 0

    if let prereleaseAndBuild {
      let parts = prereleaseAndBuild.split(separator: "+", maxSplits: 1)
      prerelease = String(parts[0])
      buildMetadata = parts.count > 1 ? String(parts[1]) : nil
    } else {
      prerelease = nil
      buildMetadata = nil
    }

    self.major = major
    self.minor = minor
    self.patch = patch
  }

  // MARK: - Codable

  private init(versionString: String, decoder: any Decoder) throws {
    do {
      try self.init(string: versionString)
      return
    } catch {
      throw DecodingError.dataCorrupted(
        .init(
          codingPath: decoder.codingPath,
          debugDescription: "Invalid version string format: \(error)"
        )
      )
    }
  }

  // swiftlint:disable:next function_body_length
  private init(jsonDecoder decoder: any Decoder) throws {
    let objectContainer = try decoder.container(keyedBy: CodingKeys.self)
    let major = try objectContainer.decode(Int.self, forKey: .major)
    let minor = try objectContainer.decode(Int.self, forKey: .minor)
    let patch = try objectContainer.decodeIfPresent(Int.self, forKey: .patch) ?? 0
    let prerelease = try objectContainer.decodeIfPresent(String.self, forKey: .prerelease)
    let buildMetadata = try objectContainer.decodeIfPresent(
      String.self,
      forKey: .buildMetadata
    )
    self.init(
      major: major,
      minor: minor,
      patch: patch,
      prerelease: prerelease,
      buildMetadata: buildMetadata
    )
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()

    // Try to decode as string first
    if let versionString = try? container.decode(String.self) {
      try self.init(versionString: versionString, decoder: decoder)
    } else {
      try self.init(jsonDecoder: decoder)
    }
  }

  public func encode(to encoder: any Encoder) throws {
    // Check encoding format and default to object if not specified
    let format = encoder.userInfo[SemVer.encodingFormatKey] as? EncodingFormat ?? .object
    if format == .string {
      var container = encoder.singleValueContainer()
      try container.encode(description)
    } else {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(major, forKey: .major)
      try container.encode(minor, forKey: .minor)
      try container.encode(patch, forKey: .patch)
      try container.encodeIfPresent(prerelease, forKey: .prerelease)
      try container.encodeIfPresent(buildMetadata, forKey: .buildMetadata)
    }
  }
}

// MARK: - CustomStringConvertible

// MARK: - Comparable
