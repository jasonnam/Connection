//
//  ShortestPathStraightLinesTests.swift
//  
//
//  Created by Federico Zanetello on 11/3/19.
//

import XCTest
import Connection

final class ShortestPathStraightLinesTests: XCTestCase {
  func testUnlinkedLines() {
    let lineAnodes: [Node<String>] = (1..<10).map { Node(value: "A\($0)") }

    zip(lineAnodes, lineAnodes.dropFirst()).forEach { nodeA, nodeB in
      nodeA.addConnection(to: nodeB, weight: 1)
    }

    let lineBnodes: [Node<String>] = (1..<10).map { Node(value: "B\($0)") }

    zip(lineBnodes, lineBnodes.dropFirst()).forEach { nodeA, nodeB in
      nodeA.addConnection(to: nodeB, weight: 1)
    }

    let graph = Graph<String>(lineAnodes + lineBnodes)

    let disconnectedPath = graph.findPath(from: lineAnodes.randomElement()!,
                                          to: lineBnodes.randomElement()!)

    XCTAssertTrue(disconnectedPath.isEmpty)
  }

  func testLinkedExtremesLines() {
    let lineAnodes: [Node<String>] = (1..<10).map { Node(value: "A\($0)") }

    zip(lineAnodes, lineAnodes.dropFirst()).forEach { nodeA, nodeB in
      nodeA.addConnection(to: nodeB, weight: 1)
    }

    let lineBnodes: [Node<String>] = (1..<10).map { Node(value: "B\($0)") }

    zip(lineBnodes, lineBnodes.dropFirst()).forEach { nodeA, nodeB in
      nodeA.addConnection(to: nodeB, weight: 1)
    }

    lineAnodes.last?.addConnection(to: lineBnodes.first!, weight: 1)

    let graph = Graph<String>(lineAnodes + lineBnodes)

    let disconnectedPath = graph.findPath(from: lineAnodes.randomElement()!,
                                          to: lineBnodes.randomElement()!)

    XCTAssertFalse(disconnectedPath.isEmpty)
  }

  func testCrossLines() {
    let lineAnodes: [Node<String>] = (1..<10).map { Node(value: "A\($0)") }

    zip(lineAnodes, lineAnodes.dropFirst()).forEach { nodeA, nodeB in
      nodeA.addConnection(to: nodeB, bidirectional: true, weight: 1)
    }

    let lineBnodes: [Node<String>] = (1..<10).map { Node(value: "B\($0)") }

    zip(lineBnodes, lineBnodes.dropFirst()).forEach { nodeA, nodeB in
      nodeA.addConnection(to: nodeB, bidirectional: true, weight: 1)
    }

    lineAnodes.randomElement()?.addConnection(to: lineBnodes.randomElement()!,
                                              weight: 1)

    let graph = Graph<String>(lineAnodes + lineBnodes)

    let disconnectedPath = graph.findPath(from: lineAnodes.randomElement()!,
                                          to: lineBnodes.randomElement()!)

    XCTAssertFalse(disconnectedPath.isEmpty)
  }
}
