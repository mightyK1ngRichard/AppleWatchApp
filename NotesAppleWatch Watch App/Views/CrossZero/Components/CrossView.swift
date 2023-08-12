//
//  CrossView.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import SwiftUI

struct CrossView: View {
    
    private var color: Color? {
        [Color.cyan, Color.mint,
         Color.pink, Color.orange,
         Color.indigo, Color.purple,
         Color.teal].randomElement()
    }
    var size: CGFloat
    var height: CGFloat = 10
    
    var body: some View {
        ZStack {
            Strick(45)
            Strick(-45)
        }
        .shadow(color: .purple, radius: 3, x: 2, y: 1)
        .overlay(
            ZStack {
                Strick(45)
                Strick(-45)
            }
                .foregroundColor(color ?? .pink)
        )
    }
    
    private func Strick(_ fraction: Double) -> some View {
        Capsule()
            .frame(width: size, height: height)
            .rotationEffect(.degrees(fraction), anchor: .center)
    }
}


struct CrossView_Previews: PreviewProvider {
    static var previews: some View {
        CrossView(size: 200)
    }
}
