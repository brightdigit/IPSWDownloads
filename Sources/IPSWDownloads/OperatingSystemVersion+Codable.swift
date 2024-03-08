//
//  OperatingSystemVersion+Codable.swift
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

import Foundation

extension OperatingSystemVersion:
  Codable,
  CustomDebugStringConvertible,
  CustomStringConvertible {
  public enum CodingKeys: String, CodingKey {
    case majorVersion
    case minorVersion
    case patchVersion
  }

  public enum Error: Swift.Error, Equatable {
    case invalidFormatString(String)
    case invalidComponentsCount(Int)
  }

  public var debugDescription: String {
    // swiftlint:disable:next line_length
    "OperatingSystemVersion(majorVersion: \(majorVersion), minorVersion: \(minorVersion), patchVersion: \(patchVersion))"
  }

  public var description: String {
    string()
  }

  public init(string: String) throws {
    let components = Self.componentsFrom(string)

    guard components.count == 2 || components.count == 3 else {
      throw RuntimeError.invalidVersion(string)
    }

    self.init(
      majorVersion: components[0],
      minorVersion: components[1],
      patchVersion: components.count == 3 ? components[2] : 0
    )
  }

  private init(container: any SingleValueDecodingContainer) throws {
    let intArrayResult = Result {
      try container.decode(String.self)
    }
    .map(Self.componentsFrom(_:))
    .flatMapError { _ in
      Result {
        try container.decode([Int].self)
      }
    }
    try self.init(components: intArrayResult.get())
  }

  private init(compositeFrom decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let majorVersion: Int = try container.decode(Int.self, forKey: .majorVersion)
    let minorVersion: Int = try container.decode(Int.self, forKey: .minorVersion)
    let patchVersion: Int = try container.decode(Int.self, forKey: .patchVersion)
    self.init(
      majorVersion: majorVersion,
      minorVersion: minorVersion,
      patchVersion: patchVersion
    )
  }

  public init(components: [Int]) throws {
    guard components.count == 2 || components.count == 3 else {
      throw Self.Error.invalidComponentsCount(components.count)
    }

    self.init(
      majorVersion: components[0],
      minorVersion: components[1],
      patchVersion: components.count == 3 ? components[2] : 0
    )
  }

  // swiftlint:disable:next function_body_length
  public init(from decoder: any Decoder) throws {
    let throwingError: (any Swift.Error)?
    if let container = Self.singleStringDecodingContainer(from: decoder) {
      do {
        try self.init(container: container)
        return
      } catch {
        throwingError = error
      }
    } else {
      throwingError = nil
    }
    do {
      try self.init(compositeFrom: decoder)
    } catch {
      throw throwingError ?? error
    }
  }

  private static func singleStringDecodingContainer(
    from decoder: any Decoder
  ) -> (any SingleValueDecodingContainer)? {
    try? decoder.singleValueContainer()
  }

  private static func componentsFrom(_ string: String) -> [Int] {
    string.components(separatedBy: ".").compactMap(Int.init)
  }

  public func encode(to encoder: any Encoder) throws {
    let throwingError: any Swift.Error
    do {
      try encodeAsString(to: encoder)
      return
    } catch {
      throwingError = error
    }
    do {
      try encodeAsComposite(to: encoder)
    } catch {
      throw throwingError
    }
  }

  internal func string(trimZeroPatch: Bool = false) -> String {
    let values: [Int?] = [
      majorVersion,
      minorVersion,
      (!trimZeroPatch || patchVersion > 0) ? patchVersion : nil
    ]
    return values.compactMap {
      $0?.description
    }
    .joined(separator: ".")
  }

  private func encodeAsString(to encoder: any Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(description)
  }

  private func encodeAsComposite(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: Self.CodingKeys.self)
    try container.encode(majorVersion, forKey: .majorVersion)
    try container.encode(minorVersion, forKey: .minorVersion)
    try container.encode(patchVersion, forKey: .patchVersion)
  }
}
