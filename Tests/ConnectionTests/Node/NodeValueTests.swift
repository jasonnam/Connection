//
//  NodeValueTests.swift
//
//
//  Created by Federico Zanetello on 11/2/19.
//

import XCTest
import Connection

final class NodeValueTests: XCTestCase {
  func testInitializeNode() {
    let value: String = UUID().uuidString
    let node = Node(value: value)

    XCTAssertEqual(node.value, value)
  }
}
