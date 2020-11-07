 //
 //  EmojiMemoryGameView.swift
 //  Memorize
 //
 //  Created by Muskaan Agrawal on 9/5/20.
 //  Copyright © 2020 Muskaan Agrawal. All rights reserved.
 //
 
 import SwiftUI
 
 struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

        
    var body: some View {
        HStack {
            Text("Theme: \(viewModel.getThemeName())")
            Text("Score: \(viewModel.score)")
        }
        .padding(.top)
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                viewModel.choose(card: card)    
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(viewModel.getColor())
        
        Button(action: { viewModel.updateMemoryGame()}) {
             Text("New Game")
         }
         
        
    }
 }
 
 struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
             ZStack{
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
 }
 
 //MARK: - Drawing Constants
 private func fontSize(for size: CGSize) -> CGFloat {
    min(size.width, size.height) * 0.75
 }
 }
 
 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
 }
