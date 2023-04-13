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
            HStack {
                VStack {
                    Text("L2")
                        .background(viewModel.buttonL2 ? Color.red : Color.clear)
                    Text("L1")
                        .background(viewModel.buttonL1 ? Color.red : Color.clear)
                }
                .padding()
                Spacer()
                VStack {
                    Text("R2")
                        .background(viewModel.buttonR2 ? Color.red : Color.clear)
                    Text("R1")
                        .background(viewModel.buttonR1 ? Color.red : Color.clear)
                }
                .padding()
            }
            .padding()
            HStack {
                ZStack {
                    VStack {
                        Text("↑")
                            .background(viewModel.buttonUp ? Color.red : Color.clear)
                        HStack {
                            Text("←")
                                .background(viewModel.buttonLeft ? Color.red : Color.clear)
                            Text("　")
                            Text("→")
                                .background(viewModel.buttonRight ? Color.red : Color.clear)
                        }
                        Text("↓")
                            .background(viewModel.buttonDown ? Color.red : Color.clear)
                    }
                    Text("●")
                        .offset(x: viewModel.buttonCursorOffsetX * 25.0, y: viewModel.buttonCursorOffsetY * -25.0)
                }
                Text("Option")
                    .background(viewModel.buttonOption ? Color.red : Color.clear)
                    .padding()
                Spacer()
                Text("Menu")
                    .background(viewModel.buttonMenu ? Color.red : Color.clear)
                    .padding()
                if viewModel.controllerProduct == .Switch {
                    VStack {
                        Text("X")
                            .background(viewModel.buttonX ? Color.red : Color.clear)
                        HStack {
                            Text("Y")
                                .background(viewModel.buttonY ? Color.red : Color.clear)
                            Text("　")
                            Text("A")
                                .background(viewModel.buttonA ? Color.red : Color.clear)
                        }
                        Text("B")
                            .background(viewModel.buttonB ? Color.red : Color.clear)
                    }
                } else if viewModel.controllerProduct == .Xbox {
                    VStack {
                        Text("Y")
                            .background(viewModel.buttonY ? Color.red : Color.clear)
                        HStack {
                            Text("X")
                                .background(viewModel.buttonX ? Color.red : Color.clear)
                            Text("　")
                            Text("B")
                                .background(viewModel.buttonB ? Color.red : Color.clear)
                        }
                        Text("A")
                            .background(viewModel.buttonA ? Color.red : Color.clear)
                    }
                } else {
                    VStack {
                        Text("△")
                            .background(viewModel.buttonY ? Color.red : Color.clear)
                        HStack {
                            Text("□")
                                .background(viewModel.buttonX ? Color.red : Color.clear)
                            Text("　")
                            Text("◯")
                                .background(viewModel.buttonB ? Color.red : Color.clear)
                        }
                        Text("×")
                            .background(viewModel.buttonA ? Color.red : Color.clear)
                    }
                }
            }
            .padding()
            HStack {
                Spacer()
                Text("◯")
                    .background(viewModel.buttonStickL ? Color.red : Color.clear)
                    .offset(x: viewModel.buttonStickLOffsetX * 20.0, y: viewModel.buttonStickLOffsetY * -20.0)
                Spacer()
                Text("◯")
                    .background(viewModel.buttonStickR ? Color.red : Color.clear)
                    .offset(x: viewModel.buttonStickROffsetX * 20.0, y: viewModel.buttonStickROffsetY * -20.0)
                Spacer()
            }
            .padding()
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
