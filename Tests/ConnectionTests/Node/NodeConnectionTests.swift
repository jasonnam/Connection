//
//  NodeConnectionTests.swift
//  
//
//  Created by Federico Zanetello on 12/10/19.
//

import XCTest
import Connection

final class NodeConnectionTests: XCTestCase {
  func testNoConnectedVertices() {
    let node = Node(value: "")

    XCTAssertTrue(node.connectedVertices.isEmpty)
  }

  func testAddConnection() {
    let node = Node(value: "")
    let connectedNode = Node(value: "")

    node.addConnection(to: connectedNode, bidirectional: true)

    XCTAssertFalse(node.connectedVertices.isEmpty)
    XCTAssertEqual(node.connectedVertices.count, 1)
    XCTAssertTrue(node.connectedVertices.contains(connectedNode))
  }

  func testAddRemoveConnection() {
    let node = Node(value: "")
    let temporaryConnectedNode = Node(value: "")

    node.addConnection(to: temporaryConnectedNode, bidirectional: true)
    node.removeConnection(to: temporaryConnectedNode, bidirectional: true)
    XCTAssertTrue(node.connectedVertices.isEmpty)
  }

  func testAddArbitraryNumberOfConnections() {
    let node = Node(value: 1)
    let nodes: [Node] = (1...Int.random(in: 2...10)).map(Node.init)

    node.addConnections(to: nodes, bidirectional: false)

    XCTAssertEqual(node.connectedVertices.count, nodes.count)

    for destinationNode in nodes {
      XCTAssertEqual(node.cost(to: destinationNode), 1)
    }
  }
}
