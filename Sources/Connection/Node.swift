//
//  Graph.swift
//
//
//  Created by Federico Zanetello on 11/2/19.
//

import GameplayKit

/// Fundamental unit of which graphs are formed.
open class Node<T>: GKGraphNode {

  /// Instance associated with this node.
  public let value: T

  /// Costs to reach each connected node.
  private var connectionWeight: [GKGraphNode: Float] = [:]

  public init(value: T) {
    self.value = value
    super.init()
  }

  override public var description: String {
    String(describing: value)
  }

  public override func cost(to node: GKGraphNode) -> Float {
    connectionWeight[node] ?? (node == self ? 0 : Float.infinity)
  }

  /// Add a connection to a single node indicating that it can be reached from
  /// this node.
  ///
  /// This is a convenience method for
  /// `addConnections(to:bidirectional:weight:)`.
  ///
  /// - Note: A new connection is not created if it already exists.
  ///
  /// - SeeAlso: `addConnections(to:bidirectional:weight:)`
  ///
  /// - Parameters:
  ///   - node: The array of nodes that are end points for their respective
  ///     connections.
  ///   - bidirectional: should a connection also be added connecting the
  ///     destination node back to this node?
  ///   - weight: the cost of the connection from this `Node` instance to the
  ///     given nodes.
  public func addConnection(to node: GKGraphNode,
                            bidirectional: Bool = false,
                            weight: Float = 1) {
    addConnections(to: [node], bidirectional: bidirectional, weight: weight)
  }

  /// Add a connection to a group of other nodes indicating those nodes can be
  /// reached from this node.
  ///
  /// - Note: A new connection is not created if it already exists.
  ///
  /// - SeeAlso: `addConnection(to:bidirectional:weight:)`
  ///
  /// - Parameters:
  ///   - node: The array of nodes that are end points for their respective
  ///     connections.
  ///   - bidirectional: should a connection also be added connecting the
  ///     destination node back to this node?
  ///   - weight: the cost of the connection from this `Node` instance to the
  ///     given nodes.
  public func addConnections(to nodes: [GKGraphNode],
                             bidirectional: Bool = false,
                             weight: Float = 1) {
    super.addConnections(to: nodes, bidirectional: bidirectional)

    for node in nodes {
      // A new connection is not created if it already exists.
      if connectionWeight[node] == nil {
        connectionWeight[node] = weight
      }

      if
        bidirectional,
        let node = node as? Node,
        node.connectionWeight[self] == nil {
        node.connectionWeight[self] = weight
      }
    }
  }

  ///  Removes the connection to the given nodes, indicating that this node can
  ///  no longer be reached from this `Node` instance.
  ///
  ///  This is a convenience method for `removeConnections(to:bidirectional:)`.
  ///
  ///  - Node: Nothing happens if a particular connection does not exist.
  ///
  /// - SeeAlso: `removeConnections(to:bidirectional:)`
  ///
  /// - Parameters:
  ///   - node: The node that is the end point of the edge to be removed.
  ///   - bidirectional: Should the connection from the given node back to this
  ///     node also be removed (if it exists)?
  public func removeConnection(to node: GKGraphNode,
                               bidirectional: Bool) {
    removeConnections(to: [node], bidirectional: bidirectional)
  }

  public override func removeConnections(to nodes: [GKGraphNode],
                                         bidirectional: Bool) {
    super.removeConnections(to: nodes, bidirectional: bidirectional)

    nodes.forEach { connectionWeight[$0] = nil }

    if bidirectional {
      nodes.forEach { ($0 as? Node)?.connectionWeight[self] = nil }
    }
  }

  /// List of other graph nodes that this node has an edge leading to.
  public var connectedVertices: [Node<T>] {
    super.connectedNodes.compactMap { $0 as? Self }
  }

  /// This initializer is unavailable: use `init(value:)` instead.
  @available(*, unavailable)
  required public init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  /// This function is unavailable: use
  /// `addConnections(to:bidirectional:weight:)` instead.
  @available(*, unavailable)
  public override func addConnections(to nodes: [GKGraphNode],
                                      bidirectional: Bool) {
    super.addConnections(to: nodes, bidirectional: bidirectional)
  }

  /// This property is unavailable: use `connectedVertices` instead.
  @available(*, unavailable)
  public override var connectedNodes: [GKGraphNode] {
    super.connectedNodes
  }
}
