//
//  ShortestPathMultipleNodesBaseCaseTests.swift
//  
//
//  Created by Federico Zanetello on 11/3/19.
//

import XCTest
import Connection

final class ShortestPathMultipleNodesBaseCaseTests: XCTestCase {
  func testPathBetweenUnknownNodes() {
    let unknownOriginNodes = (1...Int.random(in: 2...10)).map(Node.init)
    let unknownDestinationNodes = (1...Int.random(in: 2...10)).map(Node.init)

    let graph: Graph<Int> = Graph()
    let path: [Node] = graph.findPath(from: unknownOriginNodes,
                                      to: unknownDestinationNodes)

    XCTAssertTrue(path.isEmpty)
  }

  func testPathDisconnectedNodes() {
    let originNodes = (1...Int.random(in: 2...10)).map(Node.init)
    let destinationNodes = (1...Int.random(in: 2...10)).map(Node.init)

    let graph: Graph<Int> = Graph(originNodes + destinationNodes)
    let path: [Node] = graph.findPath(from: originNodes, to: destinationNodes)

    XCTAssertTrue(path.isEmpty)
  }
}
