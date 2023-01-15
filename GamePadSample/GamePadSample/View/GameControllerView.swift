//
//  GameControllerView.swift
//  GamePadSample
//
//  Created by 藤治仁 on 2023/01/15.
//

import SwiftUI

struct GameControllerView: View {
    @StateObject var viewModel = GameControllerViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameControllerView()
    }
}
