//
//  NodeConnectionWeightTests.swift
//  
//
//  Created by Federico Zanetello on 11/2/19.
//

import XCTest
import Connection

final class NodeConnectionWeightTests: XCTestCase {
  func testCostToSelf() {
    let node = Node(value: "")

    XCTAssertEqual(node.cost(to: node), 0)
  }

  func testCostToUnlinkedNode() {
    let node = Node(value: "")
    let unlinkedNode = Node(value: "")

    XCTAssertEqual(node.cost(to: unlinkedNode), Float.infinity)
    XCTAssertEqual(unlinkedNode.cost(to: node), Float.infinity)
  }

  func testCostToBidirectionalLinkedNode() {
    let node = Node(value: "")
    let linkedNode = Node(value: "")

    let connectionWeight = Float.random(in: 0...1)
    node.addConnection(to: linkedNode,
                       bidirectional: true,
                       weight: connectionWeight)

    XCTAssertEqual(node.cost(to: linkedNode), connectionWeight)
    XCTAssertEqual(linkedNode.cost(to: node), connectionWeight)
  }

  func testCostToNonBidirectionalLinkedNode() {
    let node = Node(value: "")
    let linkedNode = Node(value: "")

    let connectionWeight = Float.random(in: 0...1)
    node.addConnection(to: linkedNode,
                       bidirectional: false,
                       weight: connectionWeight)

    XCTAssertEqual(node.cost(to: linkedNode), connectionWeight)
    XCTAssertEqual(linkedNode.cost(to: node), Float.infinity)
  }

  func testCostToNonBidirectionalMutuallyLinkedNode() {
    let node = Node(value: "")
    let linkedNode = Node(value: "")

    let connectionWeight = Float.random(in: 0...1)
    node.addConnection(to: linkedNode,
                       bidirectional: false,
                       weight: connectionWeight)

    let differentConnectionWeight = Float.random(in: 0...1)
    linkedNode.addConnection(to: node,
                             bidirectional: false,
                             weight: differentConnectionWeight)

    XCTAssertEqual(node.cost(to: linkedNode), connectionWeight)
    XCTAssertEqual(linkedNode.cost(to: node), differentConnectionWeight)
  }
}
