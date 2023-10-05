//
//  ContentView.swift
//  WordScramble
//
//  Created by Dennis Mutwiri Mugambi on 05/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List(0..<5) {
            Text("Dynamic row \($0)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
