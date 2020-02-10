//
//  Graph.swift
//  
//
//  Created by Federico Zanetello on 11/3/19.
//

/// Directed set of `Node` instances.
open class Graph<T> {
  private var connectionGraph: ConnectionGraph<T>

  public init(_ nodes: [Node<T>] = []) {
    self.connectionGraph = ConnectionGraph<T>(nodes)
  }

  /// The list of nodes in this graph.
  public var nodes: [Node<T>] {
    connectionGraph.nodes?.compactMap { $0 as? Node } ?? []
  }

  /// Attempts to find the optimal path between the two given nodes.
  ///
  /// If such a path exists, it is returned in start to end order.
  /// If it doesn't exist, the array returned will be empty.
  ///
  /// - Parameters:
  ///   - startNode: `Node` to start pathing from.
  ///   - endNode: Goal `Node` of the pathfinding attempt.
  public func findPath(from startNode: Node<T>,
                       to endNode: Node<T>) -> [Node<T>] {
    connectionGraph.findPath(from: startNode, to: endNode)
  }

  /// Attempts to find the shortest path between any of the given nodes.
  ///
  /// If such a path exists, it is returned in start to end order.
  /// If it doesn't exist, the array returned will be empty.
  ///
  /// - Parameters:
  ///   - startNodes: An array of `Node`s to start pathing from.
  ///   - endNodes: Goal `Node`s of the pathfinding attempt.
  public func findPath(from startNodes: [Node<T>],
                       to endNodes: [Node<T>]) -> [Node<T>] {
    connectionGraph.findPath(from: startNodes, to: endNodes)
  }

  /// Returns the total cost of the given path.
  public func cost(of path: [Node<T>]) -> Float {
    var total: Float = 0

    zip(path, path.dropFirst()).forEach { currentNode, nextNode in
      total += currentNode.cost(to: nextNode)
    }

    return total
  }
}
