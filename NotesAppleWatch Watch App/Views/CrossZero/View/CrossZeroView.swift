//
//  CrossZeroView.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import SwiftUI

struct CrossZeroView: View {
    
    // MARK: PROPERTY
    
    @State private var isCross        = false
    @State private var pressedRows    = Array(repeating: Array(repeating: -1, count: 3), count: 3)
    @State private var winnderIndexes : [[Int]]?
    @State private var gameFinished   = false
    @State private var pressedReset   = false

    // MARK: BODY
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let height = size.height / 3
            
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                ForEach(0...8, id: \.self) { index in
                    Square(parentIsCross: $isCross,
                           pressedRows: $pressedRows,
                           winnderIndexes: $winnderIndexes,
                           gameFinished: $gameFinished,
                           pressedReset: $pressedReset,
                           height: height,
                           proxy: proxy.size,
                           index: index)
                }
            }
            .cornerRadius(10)
        }
        .overlay(alignment: .bottom) {
            Button {
                restartGame()
                
            } label: {
                Label {
                    Text("Новая игра")
                } icon: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }
            }
            .frame(height: 10)
            .offset(y: (gameFinished) ? 0 : 200)
        }
        .onChange(of: pressedRows) { newValue in
            if !pressedRows.flatMap({ $0 }).contains(-1) {
                gameFinished = true
            }
        }
    }
    
    private func restartGame() {
        pressedReset.toggle()
        isCross = false
        pressedRows = Array(repeating: Array(repeating: -1, count: 3), count: 3)
        winnderIndexes = nil
        gameFinished = false
        
    }
}

struct Square: View {
    
    // MARK: PROPERTY
    
    @State private var isHidden = true
    @State private var isCross  = false
    @Binding var parentIsCross  : Bool
    @Binding var pressedRows    : [[Int]]
    @Binding var winnderIndexes : [[Int]]?
    @Binding var gameFinished   : Bool
    @Binding var pressedReset   : Bool
    
    var height                  : CGFloat
    var proxy                   : CGSize
    var index                   : Int
    private var section: Int {
        index / 3
    }
    private var row: Int {
        index % 3
    }
    private var isWinnerItem: Bool {
        guard let arr = winnderIndexes else { return false }
        return arr.containtInt(section, row)
    }
    
    // MARK: BODY
    
    var body: some View {
        Button {
            guard !gameFinished else { return }
            
            withAnimation {
                if isHidden {
                    /// Если уже нажат, значит не будем учитывать переключение.
                    parentIsCross.toggle()
                }
            }
            
            withAnimation(.easeIn(duration: 0.55)) {
                isHidden = false
            }
            pressedRows[section][row] = parentIsCross ? 1 : 0
            let gameResult = checkBoard()
            if gameResult.gameIsFinish, let indexes = gameResult.winningIndexes {
                withAnimation {
                    winnderIndexes = indexes
                    gameFinished = gameResult.gameIsFinish
                }
            }
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(isWinnerItem && !isHidden ?
                          LinearGradient(colors: [.mint.opacity(0.5), .indigo.opacity(0.5), .pink.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing) :
                            LinearGradient(colors: [.clear], startPoint: .bottom, endPoint: .top))
                
                Rectangle()
                    .fill(gameFinished ? .black : (isHidden ? .pink.opacity(0.8) : .clear))
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
        .disabled(gameFinished && isHidden)
        .onChange(of: pressedReset) { _ in
            reset()
        }
    }
    
    // MARK: FUNCTIONS
    
    private func fetchCurrentStateOfCross() {
        isCross = parentIsCross
    }
    
    func reset() {
        isHidden = true
        isCross  = false
    }
    
    // MARK: LOGIC FUNCTIONS
    
    private func checkBoard() -> GameResults {
        var result = GameResults(gameIsFinish: false)
        
        /// Проверка столбцов
        for i in 0...2 {
            if pressedRows[0][i] != -1 &&
                pressedRows[0][i] == pressedRows[1][i] &&
                pressedRows[0][i] == pressedRows[2][i] {
                result.winningIndexes = [[0, i], [1, i], [2, i]]
                result.winnderIsCross = pressedRows[0][i] == 1
                result.gameIsFinish = true
                return result
            }
        }
        
        /// Проверка строк
        for i in 0...2 {
            if pressedRows[i][0] != -1 &&
                pressedRows[i][0] == pressedRows[i][1] &&
                pressedRows[i][0] == pressedRows[i][2]{
                result.winningIndexes = [[i, 0], [i, 1], [i, 2]]
                result.winnderIsCross = pressedRows[i][0] == 1
                result.gameIsFinish = true
                return result
            }
        }
        
        /// Проверка диагоналей
        if pressedRows[1][1] != -1 &&
            pressedRows[0][0] == pressedRows[1][1] &&
            pressedRows[2][2] == pressedRows[1][1] {
            
            result.gameIsFinish = true
            result.winnderIsCross = pressedRows[1][1] == 1
            result.winningIndexes = [[0,0], [1,1], [2,2]]
            return result
            
        } else if pressedRows[0][2] != -1 &&
                    pressedRows[0][2] == pressedRows[1][1] &&
                    pressedRows[2][0] == pressedRows[1][1] {
            
            result.gameIsFinish = true
            result.winnderIsCross = pressedRows[1][1] == 1
            result.winningIndexes = [[2,0], [1,1], [0,2]]
            return result
        }
        
        return result
    }
    
    private func TempFuncForGameResult() -> Bool {
        let linesToCheck: [[Int]] = pressedRows + (0..<3).map { i in pressedRows.map { $0[i] } }
        let diagonalsToCheck: [[Int]] = [[0, 4, 8], [2, 4, 6]].map { $0.map { pressedRows[$0 / 3][$0 % 3] } }
        return linesToCheck.contains([0, 0, 0]) || linesToCheck.contains([1, 1, 1]) ||
        diagonalsToCheck.contains([0, 0, 0]) || diagonalsToCheck.contains([1, 1, 1])
    }
    
}

struct CrossZeroView_Previews: PreviewProvider {
    static var previews: some View {
        CrossZeroView()
    }
}

// MARK: - EXTENSIONS

private extension Array where Element == [Int] {
    func containtInt(_ first: Int, _ second: Int) -> Bool {
        for innerItems in self {
            if innerItems[0] == first && innerItems[1] == second {
                return true
            }
        }
        
        return false
    }
}
