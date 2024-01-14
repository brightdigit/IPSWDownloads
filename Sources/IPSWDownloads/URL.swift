//
//  File.swift
//
//
//  Created by Leo Dion on 1/11/24.
//
import Foundation

extension URL {
  /// Returns a validated server URL, or throws an error.
  /// - Parameter string: A URL string.
  /// - Throws: If the provided string doesn't convert to URL.
  public init(validatingURL string: String) throws {
    guard let url = Self(string: string) else { throw RuntimeError.invalidURL(string) }
    self = url
  }
}
