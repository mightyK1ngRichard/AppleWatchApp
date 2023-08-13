//
//  CrossZeroView.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import SwiftUI

struct CrossZeroView: View {
    
    // MARK: PROPERTY
    
    @State private var isCross: Bool = false
    
    // MARK: BODY
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let height = size.height / 3

            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                ForEach(0...8, id: \.self) { _ in
                    Square(parentIsCross: $isCross, height: height, proxy: proxy.size)
                }
            }
            .cornerRadius(10)
        }
    }
    
}

struct Square: View {
    
    // MARK: PROPERTY
    
    @State private var isHidden = true
    @State private var isCross  = false
    @Binding var parentIsCross  : Bool
    var height                  : CGFloat
    var proxy                   : CGSize
    
    // MARK: BODY
    
    var body: some View {
        Button {
            withAnimation {
                if isHidden {
                    /// Если уже нажат, значит не будем учитывать переключение.
                    parentIsCross.toggle()
                }
            }
            
            withAnimation(.easeIn(duration: 0.55)) {
                isHidden = false
            }
            
        } label: {
            ZStack {
                Rectangle()
                    .fill(isHidden ? .pink.opacity(0.8) : .clear)
                    .offset(x: isHidden ? 0 : proxy.width - (proxy.width / 3),
                            y: isHidden ? 0 : proxy.height - height)
                
                if !isHidden && isCross {
                    CrossView(size: 60, height: 5)
                        .onAppear(perform: fetchCurrentStateOfCross)
                    
                } else if !isHidden && !isCross {
                    ZeroView(size: 40)
                        .onAppear(perform: fetchCurrentStateOfCross)
                }
                
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(height: height)
    }
    
    // MARK: FUNCTIONS
    
    private func fetchCurrentStateOfCross() {
        isCross = parentIsCross
    }
}

struct CrossZeroView_Previews: PreviewProvider {
    static var previews: some View {
        CrossZeroView()
    }
}
