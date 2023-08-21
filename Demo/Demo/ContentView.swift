//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-08-21.
//

import PrintingKit
import SwiftUI

struct ContentView: View {
    
    let url = Bundle.main.url(forResource: "tmp", withExtension: "pdf")
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(url?.absoluteString ?? "-")
            Button("PRINT") {
                if let url {
                    StandardPrinter().printItem(.pdf(at: url))
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
