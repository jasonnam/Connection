<p align="center">
    <img src="logo.png" width="400" max-width="90%" alt="Connection" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.1-orange.svg" />
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/swiftpm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
    </a>
     <img src="https://img.shields.io/badge/platforms-macOS+iOS+iPadOS+tvOS-brightgreen.svg?style=flat" alt="MacOS + iOS + iPadOS + tvOS" />
    <a href="https://twitter.com/zntfdr">
        <img src="https://img.shields.io/badge/twitter-@zntfdr-blue.svg?style=flat" alt="Twitter: @zntfdr" />
    </a>
</p>

Welcome to **Connection**, a Swift path-finding library. Its primary goal is to extend Apple's [`GameplayKit`](https://developer.apple.com/documentation/gameplaykit) framework.

## Features

- [x] Weighted connections.
- [x] Total path weight.
- [x] Associated values support.
- [x] Find the shortest path between multiple origins and destinations.

## Usage
Connection defines two new generic classes: `Node` and `Graph`, which are, respectively, [`GKGraphNode`](https://developer.apple.com/documentation/gameplaykit/gkgraphnode) and [`GKGraph`](https://developer.apple.com/documentation/gameplaykit/gkgraph) counterparts.

```swift
import Connection

// Create nodes.
let nodeA = Node(value: "A")
let nodeB = Node(value: "B")
let nodeC = Node(value: "C")

// Make connections.
nodeA.addConnection(to: nodeB, bidirectional: false, weight: 1)
nodeB.addConnection(to: nodeC, bidirectional: true, weight: 2)

// Create graph.
let graph = Graph([nodeA, nodeB, nodeC])

// Find path.
let shortestAtoCPath = graph.findPath(from: nodeA, to: nodeC)

print(shortestAtoCPath) // ["A", "B", "C"]
```
You can find many more examples in the [`Tests`](https://github.com/zntfdr/Connection/tree/master/Tests) folder.

## Installation

Connection is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it into a project, follow [this tutorial](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app) with the following url: `https://github.com/zntfdr/Connection.git`.

## Credits

Connection was built by [Federico Zanetello](https://twitter.com/zntfdr) as a component of [Bangkok Metro](http://yourmetro.app).

If you'd like to dive deeper in iOS path-finding algorithms, please read this two-part serie:

- [Dijkstra’s Algorithm In Swift](https://www.fivestars.blog/code/dijkstra-algorithm-swift.html#swift-time)
- [The Right Way To Write Dijkstra’s Algorithm In Swift 👾](https://www.fivestars.blog/code/dijkstra-algorithm-swift-2.html)

## Contributions and Support

All users are welcome and encouraged to become active participants in the project continued development — by fixing any bug that they encounter, or by improving the documentation wherever it’s found to be lacking.

If you'd like to make a change, please [open a Pull Request](https://github.com/zntfdr/Connection/pull/new), even if it just contains a draft of the changes you’re planning, or a test that reproduces an issue.

Thank you and please enjoy using **Connection**!