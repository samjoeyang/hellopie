//
//  GuessTheCarLogoView.swift
//  HelloPieApp
//
//  Created by Samjoe Yang on 2022/6/21.
//

import SwiftUI

struct GuessTheCarLogoView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
//    @State private var carlogoList = CarLogoCollection[]
    
    @State private var carlogos = ["audi","benz","bmw","citroen","ford","lexus","volvo"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Car Logo")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the logo of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(carlogos[correctAnswer].uppercased())
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(carlogos[number])
                                .resizable()
                                .frame(width: 80, height: 80, alignment: .center)
//                                .interpolation(.high)
//                                .antialiased(true)
//                                .transformEffect(.init(rotationAngle: CGFloat(Double.pi/8)))
//                                .renderingMode(.original)
//                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: ???")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is ???")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        carlogos.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct GuessTheCarLogoView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheCarLogoView()
    }
}
