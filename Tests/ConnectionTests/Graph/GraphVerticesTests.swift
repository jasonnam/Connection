//
//  GraphVerticesTests.swift
//  
//
//  Created by Federico Zanetello on 11/3/19.
//

import XCTest
import Connection

final class GraphVerticesTests: XCTestCase {
  func testInitializeEmptyGraph() {
    let graph = Graph<Int>()

    XCTAssertTrue(graph.nodes.isEmpty)
  }

  func testInitializeNonEmptyGraph() {
    let node = Node(value: "")
    let graph = Graph<String>([node])

    XCTAssertFalse(graph.nodes.isEmpty)
  }

  func testInitializeGraphWithArbitraryNumberOfNodes() {
    let nodes: [Node] = (1...Int.random(in: 2...10)).map(Node.init)
    let graph = Graph<Int>(nodes)

    XCTAssertEqual(graph.nodes.count, nodes.count)

    for node in nodes {
      XCTAssertTrue(graph.nodes.contains(node))
    }
  }
}
