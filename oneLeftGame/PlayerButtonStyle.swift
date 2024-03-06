//
//  PlayerButtonStyle.swift
//  oneLeftGame
//
//  Created by PATRICIA S SIQUEIRA on 05/03/24.
//

import SwiftUI

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
