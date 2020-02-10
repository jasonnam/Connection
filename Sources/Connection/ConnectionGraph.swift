//
//  ConnectionGraph.swift
//  
//
//  Created by Federico Zanetello on 12/15/19.
//

import GameplayKit

/// Directed set of `Node` instances.
final class ConnectionGraph<T>: GKGraph {

  /// Attempts to find the optimal path between the two given nodes.
  ///
  /// If such a path exists, it is returned in start to end order.
  /// If it doesn't exist, the array returned will be empty.
  ///
  /// - Parameters:
  ///   - startNode: `Node` to start pathing from.
  ///   - endNode: Goal `Node` of the pathfinding attempt.
  func findPath(from startNode: Node<T>, to endNode: Node<T>) -> [Node<T>] {
    super.findPath(from: startNode, to: endNode).compactMap { $0 as? Node }
  }

  /// Attempts to find the shortest path between any of the given nodes.
  ///
  /// If such a path exists, it is returned in start to end order.
  /// If it doesn't exist, the array returned will be empty.
  ///
  /// - Parameters:
  ///   - startNodes: An array of `Node`s to start pathing from.
  ///   - endNodes: Goal `Node`s of the pathfinding attempt.
  func findPath(from startNodes: [Node<T>],
                to endNodes: [Node<T>]) -> [Node<T>] {
    // Create new mock, single, start node.
    let startNode = GKGraphNode()
    startNode.addConnections(to: startNodes, bidirectional: false)

    defer {
      startNode.removeConnections(to: startNodes, bidirectional: false)
    }

    // Create new mock, single, end node.
    let endNode = GKGraphNode()
    for node in endNodes {
      node.addConnection(to: endNode, bidirectional: false, weight: 0)
    }

    defer {
      endNodes.forEach {
        $0.removeConnections(to: [endNode], bidirectional: false)
      }
    }

    let path: [GKGraphNode] = findPath(from: startNode, to: endNode)

    return path.compactMap { $0 as? Node<T> }
  }
}
