//
//  ContentView.swift
//  connectionLogo
//
//  Created by Federico Zanetello on 12/10/19.
//  Copyright © 2019 Federico Zanetello. All rights reserved.
//

import SwiftUI

struct NodeView: View {
  var body: some View {
    GeometryReader { geometry in
      Circle()
        .strokeBorder(Color.black, lineWidth: geometry.size.height / 6)
        .overlay(
          Circle()
            .fill(Color.white)
            .padding(geometry.size.height / 6)
      )
    }
  }
}

struct GradientView: View {
  private let gradient = Gradient(stops: [
    Gradient.Stop(color: .white, location: 0.1),
    Gradient.Stop(color: .blue, location: 0.2),
    Gradient.Stop(color: .blue, location: 0.8),
    Gradient.Stop(color: .white, location: 0.9)
  ])

  var body: some View {
    GeometryReader { geometry in
      LinearGradient(
        gradient: self.gradient,
        startPoint: .leading,
        endPoint: .trailing
      ).frame(height: geometry.size.height / 2)
    }
  }
}

struct ContentView: View {
  var body: some View {
    VStack(spacing: 0) {
      GeometryReader { geometry in
        ZStack {
          GradientView()

          HStack {
            Spacer()
            NodeView()
              .frame(width: geometry.size.height,
                     height: geometry.size.height)
            Spacer()
            Spacer()
          }

          HStack {
            Spacer()
            Spacer()
            NodeView()
              .frame(width: geometry.size.height,
                     height: geometry.size.height)
            Spacer()
          }
        }
      }.frame(width: 500, height: 50)
      Text("Connection")
        .font(Font.system(size: 55, weight: .heavy, design: .default))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      ContentView()
      Spacer()
    }.previewLayout(.sizeThatFits)
  }
}
