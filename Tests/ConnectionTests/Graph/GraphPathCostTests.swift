//
//  GraphPathCostTests.swift
//  
//
//  Created by Federico Zanetello on 11/16/19.
//

import XCTest
import Connection

final class GraphPathCostTests: XCTestCase {
  func testNoConnection() {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)

    let graph = Graph<Int>([node1, node2])

    XCTAssertEqual(graph.cost(of: [node1, node2]), Float.infinity)
    XCTAssertEqual(graph.cost(of: [node2, node1]), Float.infinity)
  }

  func testNoConnectionRoundabount() {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)

    let graph = Graph<Int>([node1, node2])

    XCTAssertEqual(graph.cost(of: [node1, node2, node1]), Float.infinity)
    XCTAssertEqual(graph.cost(of: [node2, node1, node2]), Float.infinity)
  }

  func testZeroCost() {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)

    node1.addConnection(to: node2, bidirectional: true, weight: 0)

    let graph = Graph<Int>([node1, node2])

    XCTAssertEqual(graph.cost(of: [node1, node2]), 0)
    XCTAssertEqual(graph.cost(of: [node2, node1]), 0)
  }

  func testZeroCostRoundabount() {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)

    node1.addConnection(to: node2, bidirectional: true, weight: 0)

    let graph = Graph<Int>([node1, node2])

    XCTAssertEqual(graph.cost(of: [node1, node2, node1]), 0)
    XCTAssertEqual(graph.cost(of: [node2, node1, node2]), 0)
  }

  func testSimpleCost() {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)

    node1.addConnection(to: node2, bidirectional: true, weight: 1)

    let graph = Graph<Int>([node1, node2])

    XCTAssertEqual(graph.cost(of: [node1, node2]), 1)
    XCTAssertEqual(graph.cost(of: [node2, node1]), 1)
  }

  func testSimpleCostRoundabount() {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)

    node1.addConnection(to: node2, bidirectional: true, weight: 1)

    let graph = Graph<Int>([node1, node2])

    XCTAssertEqual(graph.cost(of: [node1, node2, node1]), 2)
    XCTAssertEqual(graph.cost(of: [node2, node1, node2]), 2)
  }

  func testDifferentCostInDifferentDirection() {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)

    node1.addConnection(to: node2, bidirectional: false, weight: 2)
    node2.addConnection(to: node1, bidirectional: false, weight: 5)

    let graph = Graph<Int>([node1, node2])

    XCTAssertEqual(graph.cost(of: [node1, node2]), 2)
    XCTAssertEqual(graph.cost(of: [node2, node1]), 5)
  }

  func testThreeBidirectionalNodePathCost() {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)

    node1.addConnection(to: node2, bidirectional: true, weight: 1)
    node2.addConnection(to: node3, bidirectional: true, weight: 2)

    let graph = Graph<Int>([node1, node2, node3])

    XCTAssertEqual(graph.cost(of: [node1, node2, node3]), 3)
    XCTAssertEqual(graph.cost(of: [node3, node2, node1]), 3)
  }

  func testThreeNodePathCostDifferentDirection() {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)

    node1.addConnection(to: node2, bidirectional: false, weight: 1)
    node2.addConnection(to: node1, bidirectional: false, weight: 2)
    node2.addConnection(to: node3, bidirectional: false, weight: 3)
    node3.addConnection(to: node2, bidirectional: false, weight: 4)

    let graph = Graph<Int>([node1, node2, node3])

    XCTAssertEqual(graph.cost(of: [node1, node2, node3]), 4)
    XCTAssertEqual(graph.cost(of: [node3, node2, node1]), 6)
  }
}
