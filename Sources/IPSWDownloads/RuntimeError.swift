//
//  File.swift
//
//
//  Created by Leo Dion on 1/11/24.
//
import Foundation

internal enum RuntimeError: Error {
  case invalidURL(String)
  case invalidVersion(String)
}
