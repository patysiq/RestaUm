//
//  GameView.swift
//  oneLeftGame
//
//  Created by PATRICIA S SIQUEIRA on 02/03/24.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: GameService
    @EnvironmentObject var connectionManager: MPConnectionManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
                Color.white
                    .ignoresSafeArea()
            VStack {
                if [game.player1.isCurrent, game.player2.isCurrent].allSatisfy({$0 == false}) {
                    Text("Selecione um jogador para iniciar")
                }
                HStack {
                    Button(game.player1.name) {
                        game.player1.isCurrent = true
                        if game.gameType == .peer {
                            let gameMove = MPGameMove(action: .start, playerName: game.player1.name, board: nil)
                            connectionManager.send(gameMove: gameMove)
                        }

                    }
                    .buttonStyle(PlayerButtonStyle(player: game.player1))
                    Button(game.player2.name) {
                        game.player2.isCurrent = true
                        if game.gameType == .peer {
                            let gameMove = MPGameMove(action: .start, playerName: game.player2.name, board: nil)
                            connectionManager.send(gameMove: gameMove)
                        }

                    }
                    .buttonStyle(PlayerButtonStyle(player: game.player2))
                }
                .disabled(game.gameStarted)
                .padding(8)
                VStack {
                    HStack {
                        ForEach(0...6, id: \.self) { index in
                            CircleView(index: index)
                        }
                    }
                    HStack {
                        ForEach(7...13, id: \.self) { index in
                            CircleView(index: index)
                        }
                    }
                    HStack {
                        ForEach(14...20, id: \.self) { index in
                            CircleView(index: index)
                        }
                    }
                    HStack {
                        ForEach(21...27, id: \.self) { index in
                            CircleView(index: index)
                        }
                    }
                    HStack {
                        ForEach(28...34, id: \.self) { index in
                            CircleView(index: index)
                        }
                    }
                    HStack {
                        ForEach(35...41, id: \.self) { index in
                            CircleView(index: index)
                        }
                    }
                    HStack {
                        ForEach(42...48, id: \.self) { index in
                            CircleView(index: index)
                        }
                    }
                    .disabled(game.boardDisabled)
                    VStack {
                        if game.gameOver {
                            Text("Game Over")
                            Text("\(game.currentPlayer.name) ganhou")
                        }
                        Button("Novo jogo") {
                            game.reset()
                            if game.gameType == .peer {
                                let gameMove = MPGameMove(action: .reset, playerName: nil, board: nil)
                                connectionManager.send(gameMove: gameMove)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .font(.largeTitle)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fim de jogo") {
                        dismiss()
                        if game.gameType == .peer {
                            let gameMove = MPGameMove(action: .end, playerName: nil, board: nil)
                            connectionManager.send(gameMove: gameMove)
                        }
                    }
                    .buttonStyle(.bordered)
                }
            }
            .navigationTitle("Resta um")
            .onAppear {
                game.reset()
                if game.gameType == .peer {
                    connectionManager.setup(game: game)
                }
            }
            .inNavigationStack()
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    GameView()
        .environmentObject(GameService())
}


struct PlayerButtonStyle: ButtonStyle {
    let player: Player
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(player.isCurrent ? Color.green : Color.gray)
            )
            .foregroundColor(.white)
        
    }
}
