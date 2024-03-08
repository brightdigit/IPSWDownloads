//
//  OperatingSystemVersion+Hashable.swift
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
  Hashable,
  Equatable,
  Comparable {
  public static func == (
    lhs: OperatingSystemVersion,
    rhs: OperatingSystemVersion
  ) -> Bool {
    lhs.majorVersion == rhs.majorVersion &&
      lhs.minorVersion == rhs.minorVersion &&
      lhs.patchVersion == rhs.patchVersion
  }

  public static func < (
    lhs: OperatingSystemVersion,
    rhs: OperatingSystemVersion
  ) -> Bool {
    guard lhs.majorVersion == rhs.majorVersion else {
      return lhs.majorVersion < rhs.majorVersion
    }
    guard lhs.minorVersion == rhs.minorVersion else {
      return lhs.minorVersion < rhs.minorVersion
    }
    return lhs.patchVersion < rhs.patchVersion
  }

  public func hash(into hasher: inout Hasher) {
    majorVersion.hash(into: &hasher)
    minorVersion.hash(into: &hasher)
    patchVersion.hash(into: &hasher)
  }
}
