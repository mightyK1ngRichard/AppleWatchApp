//
//  ZeroView.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import SwiftUI

struct ZeroView: View {
    private var color: Color? {
        [Color.cyan, Color.mint,
         Color.pink, Color.orange,
         Color.indigo, Color.purple,
         Color.teal].randomElement()
    }
    
    var size: CGFloat
    
    var body: some View {
        Circle()
            .stroke(color ?? .pink, lineWidth: 5)
            .shadow(color: .purple, radius: 4, x: 2, y: 1)
            .frame(width: size, height: size)
    }
}

struct ZeroView_Previews: PreviewProvider {
    static var previews: some View {
        ZeroView(size: 60)
    }
}
