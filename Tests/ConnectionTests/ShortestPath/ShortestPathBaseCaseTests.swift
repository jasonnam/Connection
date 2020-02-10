//
//  ShortestPathBaseCaseTests.swift
//  
//
//  Created by Federico Zanetello on 11/3/19.
//

import XCTest
import Connection

final class ShortestPathBaseCaseTests: XCTestCase {
  func testPathBetweenUnknownNodes() {
    let unknownNode = Node(value: 1)
    let unknownNode2 = Node(value: 2)

    let graph: Graph<Int> = Graph()
    let path: [Node] = graph.findPath(from: unknownNode, to: unknownNode2)

    XCTAssertTrue(path.isEmpty)
  }

  func testPathDisconnectedNodes() {
    let node = Node(value: 1)
    let node2 = Node(value: 2)

    let graph: Graph<Int> = Graph([node, node2])
    let path: [Node] = graph.findPath(from: node, to: node2)

    XCTAssertTrue(path.isEmpty)
  }

  func testPathDisconnectedNodes2() {
    let node = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)

    node3.addConnection(to: node, bidirectional: false, weight: 1)
    node3.addConnection(to: node2, bidirectional: false, weight: 1)

    let graph: Graph<Int> = Graph([node, node2, node3])
    let path: [Node] = graph.findPath(from: node, to: node2)

    XCTAssertTrue(path.isEmpty)
  }

  func testPathConnectedUnidirectionalNodes() {
    let node = Node(value: 1)
    let node2 = Node(value: 2)

    node.addConnection(to: node2, bidirectional: false, weight: 1)

    let graph: Graph<Int> = Graph([node, node2])

    let connectedPath: [Node] = graph.findPath(from: node, to: node2)
    XCTAssertFalse(connectedPath.isEmpty)
    XCTAssertEqual(connectedPath, [node, node2])

    let diconnectedPath: [Node] = graph.findPath(from: node2, to: node)
    XCTAssertTrue(diconnectedPath.isEmpty)
  }

  func testPathConnectedBidirectionalNodes() {
    let node = Node(value: 1)
    let node2 = Node(value: 2)

    node.addConnection(to: node2, bidirectional: true, weight: 1)

    let graph: Graph<Int> = Graph([node, node2])

    let connectedPath: [Node] = graph.findPath(from: node, to: node2)
    XCTAssertFalse(connectedPath.isEmpty)
    XCTAssertEqual(connectedPath, [node, node2])

    let connectedPath2: [Node] = graph.findPath(from: node2, to: node)
    XCTAssertFalse(connectedPath2.isEmpty)
    XCTAssertEqual(connectedPath2, [node2, node])
  }

  func testPathConnectedUnidirectionalNodesChain() {
    let nodes: [Node] = (1...Int.random(in: 2...10)).map(Node.init)
    let graph = Graph<Int>(nodes)

    zip(nodes, nodes.dropFirst()).forEach { nodeA, nodeB in
      nodeA.addConnection(to: nodeB, bidirectional: false, weight: 1)
    }

    let connectedPath = graph.findPath(from: nodes[0],
                                       to: nodes[nodes.count - 1])

    XCTAssertFalse(connectedPath.isEmpty)
    XCTAssertEqual(connectedPath, nodes)

    let disconnectedPath = graph.findPath(from: nodes[nodes.count - 1],
                                          to: nodes[0])
    XCTAssertTrue(disconnectedPath.isEmpty)
  }

  func testPathConnectedBidirectionalNodesChain() {
    let nodes: [Node] = (1...Int.random(in: 2...10)).map(Node.init)
    let graph = Graph<Int>(nodes)

    zip(nodes, nodes.dropFirst()).forEach { nodeA, nodeB in
      nodeA.addConnection(to: nodeB, bidirectional: true, weight: 1)
    }

    let connectedPath = graph.findPath(from: nodes[0],
                                       to: nodes[nodes.count - 1])

    XCTAssertFalse(connectedPath.isEmpty)
    XCTAssertEqual(connectedPath, nodes)

    let connectedPath2 = graph.findPath(from: nodes[nodes.count - 1],
                                        to: nodes[0])
    XCTAssertFalse(connectedPath2.isEmpty)
    XCTAssertEqual(connectedPath2, nodes.reversed())
  }
}
