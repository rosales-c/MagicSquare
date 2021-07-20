//
//  ContentView.swift
//  MagicSquare
//
//  Created by Cinthya Drake on 2/14/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = MagicSquareViewModel()
    
    let spacing: CGFloat = 0.0
    let numRows = 4
    let numColumns = 4
    
    var body: some View {
        if viewModel.gameInProgress() && !viewModel.winner(){
            VStack(spacing: spacing){
        
                buildGameView(rows: numRows, columns: numColumns)
                    .padding(.bottom, (UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.width)))
                    .padding(.leading)
                    .padding(.trailing)
                Button("New Game?"){
                    viewModel.reset()
                }
                .padding(.all, 20.0)
                .background(Color.purple)
                .foregroundColor(.white)
            }
        } else if viewModel.gameInProgress() && viewModel.winner() {
            winnerCircle()
        }
        else {
            welcomeScreen()
        }
    }
    
    @State private var shuffleReadOut = 1.0
    
    func slider() -> some View {
        return VStack {
            Slider(
                value: $shuffleReadOut,
                in: 1...3,
                step: 1,
                onEditingChanged: { editing in
                    print("editing -- readout = \(shuffleReadOut)")
                    print(editing)
                    
                },
                minimumValueLabel: Text("1"),
                maximumValueLabel: Text("3")
            ){
                Text("Shuffle Intensity")
            }
        }
        .padding(.leading, 30)
        .padding(.trailing, 30)
        
    }
    
    func buildGameView(rows: Int, columns: Int) -> some View {
        VStack(spacing: spacing) {
            ForEach(0..<rows) { row in
                buildGameRow(rows: row, columns: columns)
            }
        }
    }
    
    func buildGameRow(rows: Int, columns: Int) -> some View {
        HStack(spacing: spacing) {
            ForEach(0..<columns) { column in
                CellView(cell: viewModel.cellAt(row: rows, column: column))
                    .onTapGesture {
                        viewModel.didTapCell(row: rows, column: column)
                    }
            }
        }
    }
    
    func welcomeScreen() -> some View {
        return VStack {
            Text("Welcome!")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            Text("Please use the slider choose your difficulty")
                .padding()
            slider()
                .onTapGesture(perform: {
                    viewModel.didChooseShuffle(difficulty: Int(shuffleReadOut))
                })
                .padding()
            Text("When ready, tap slider to begin")
        }
    }
    
    func winnerCircle() -> some View {
        return VStack {
            Text("CONGRATULATIONS!")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            Text("You are a winner!")
                .padding()
            Button("Play Again?"){
                viewModel.reset()
            }
            .background(Color.purple)
            .foregroundColor(.white)
            .padding(.all, 30.0)
        }
    }
    
}

struct CellView: View {
    let cell: BoardCell
    
    var body: some View {
        return ZStack {
            Rectangle()
                .foregroundColor((cell.cellType == CellType.blankCell) ? Color.gray : Color.purple)
            Rectangle().stroke(lineWidth: strokeLineWidth).foregroundColor(.black)
            if let stringForCell = stringOverlayForCell() {
                Text(stringForCell)
            }
        }
        .font(.headline)
    }
    
    func stringOverlayForCell() -> String? {
        if case .numberCell(representing: let n) = cell.cellType{
            return String(n)
        }
        return nil
    }
    
    let strokeLineWidth : CGFloat = 1.0
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
