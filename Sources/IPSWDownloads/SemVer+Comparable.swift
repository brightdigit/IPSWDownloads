//
//  SemVer+Comparable.swift
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

extension SemVer: Comparable {
  // swiftlint:disable:next function_body_length cyclomatic_complexity
  public static func < (lhs: SemVer, rhs: SemVer) -> Bool {
    if lhs.major != rhs.major {
      return lhs.major < rhs.major
    }
    if lhs.minor != rhs.minor {
      return lhs.minor < rhs.minor
    }
    if lhs.patch != rhs.patch {
      return lhs.patch < rhs.patch
    }

    // If everything else is equal, compare pre-release versions
    switch (lhs.prerelease, rhs.prerelease) {
    case (nil, nil):
      return false

    case (nil, .some):
      return false // Release version is greater than pre-release
    case (.some, nil):
      return true // Pre-release version is less than release
    case let (lhsPre?, rhsPre?):
      // Compare pre-release identifiers
      let lhsComponents = lhsPre.split(separator: ".")
      let rhsComponents = rhsPre.split(separator: ".")

      for (lhs, rhs) in zip(lhsComponents, rhsComponents) {
        if let lNum = Int(lhs), let rNum = Int(rhs) {
          if lNum != rNum {
            return lNum < rNum
          }
        } else if Int(lhs) != nil {
          return true // Numeric is less than non-numeric
        } else if Int(rhs) != nil {
          return false // Non-numeric is greater than numeric
        } else {
          if lhs != rhs {
            return lhs.description < rhs.description
          }
        }
      }
      return lhsComponents.count < rhsComponents.count
    }
  }
}
