/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

public struct Rect {
  public static let zero: Rect = Rect(x: 0, y: 0, width: 0, height: 0)

  public var origin: Point
  public var size: Size

  public init(origin: Point, size: Size) {
    self.origin = origin
    self.size = size
  }

  public init(x: Double, y: Double, width: Double, height: Double) {
    self.init(origin: Point(x: x, y: y),
              size: Size(width: width, height: height))
  }

  public init(x: Int, y: Int, width: Int, height: Int) {
    self.init(origin: Point(x: Double(x), y: Double(y)),
              size: Size(width: Double(width), height: Double(height)))
  }

  func applying(_ transform: AffineTransform) -> Rect {
    return Rect(origin: self.origin.applying(transform),
                size: self.size.applying(transform))
  }
}

extension Rect: Equatable {
}

extension Rect: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "Rect(origin: \(origin), size: \(size))"
  }
}
