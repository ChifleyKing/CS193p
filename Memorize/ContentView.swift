//
//  ContentView.swift
//  Memorize
//
//  Created by HIN SENG LOI on 07/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State var emojis_1 = ["👻", "🎃", "👾", "👽", "🤖", "👹", "👻", "🎃", "👾", "👽", "🤖", "👹"]
    @State var emojis_2 = ["👶", "👧", "🧒", "👦", "👩", "🧑", "👶", "👧", "🧒", "👦", "👩", "🧑"]
    @State var emojis_3 = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐶", "🐱", "🐭", "🐹", "🐰", "🦊"]
    let title = "Memorize!"
    
    @State var cardCount = 4
    @State var currentTheme = 1
    //@State var isShuffled = false
    
    var body: some View {
        VStack{
            ScrollView{
                Text(title).font(.title).padding()
                cards()
            }
                Spacer()
                cardCountAdjusters
        }
        .padding()
    }
    
    var cardCountAdjusters: some View{
        HStack{
            cardRemover
            Spacer()
            theme1
            Spacer()
            theme2
            Spacer()
            theme3
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
    func cards() -> some View{
        
        let currentEmojis: [String]
        switch currentTheme {
        case 1:
            currentEmojis = emojis_1
        case 2:
            currentEmojis = emojis_2
        case 3:
            currentEmojis = emojis_3
        default:
            currentEmojis = emojis_1
        }
        
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: currentEmojis[index])
                    .aspectRatio(contentMode: .fit)
            }
            .foregroundColor(.orange)
            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        }
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
                cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis_1.count)
    }
    
    var cardRemover: some View{
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var theme1: some View{
        Button(action: {currentTheme = 1; emojis_1.shuffle()}){
            VStack{
                Image(systemName: "a.circle.fill")
                Text("Theme1")
                    .font(.system(size: 12))
            }
        }
    }
    var theme2: some View{
        Button(action: {currentTheme = 2; emojis_2.shuffle()}){
            VStack{
                Image(systemName: "b.circle.fill")
                Text("Theme2")
                    .font(.system(size: 12))
            }
        }
    }
    var theme3: some View{
        Button(action: {currentTheme = 3; emojis_3.shuffle()}){
            VStack{
                Image(systemName: "c.circle.fill")
                Text("Theme3")
                    .font(.system(size: 12))
            }
        }
    }
    
    var cardAdder: some View{
        return cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }

    
    struct CardView: View {
        let content: String
        @State var isFaceUp = false
        var body: some View {
            ZStack{
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.foregroundColor(.white)
                    base.strokeBorder(lineWidth:2)
                    Text(content)
                        .font(.system(size: 50))
                }
                .opacity(isFaceUp ? 1 : 0)
                    base.fill().opacity(isFaceUp ? 0 : 1)
            }.onTapGesture{isFaceUp.toggle()
            }
        }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
