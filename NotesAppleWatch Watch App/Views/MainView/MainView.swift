//
//  MainView.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 20) {
                    NavigationLink {
                        NotesView()
                    } label: {
                        IconView("note.text.badge.plus")
                    }
                    .buttonStyle(PlainButtonStyle())

                    NavigationLink {
                        CrossZeroView()
                        
                    } label: {
                        IconView("gamecontroller", size: 40)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
            }
            
            .navigationTitle("Режимы")
        }
    }
    
    func IconView(_ imageName: String, size: CGFloat = 50) -> some View {
        Image(systemName: imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: size)
            .foregroundColor(.yellow)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
