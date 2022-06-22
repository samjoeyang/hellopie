//
//  GuessTheCarLogoView.swift
//  HelloPieApp
//
//  Created by Samjoe Yang on 2022/6/21.
//

import SwiftUI

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}

struct GuessTheCarLogoView: View {
    @State private var showingScore = false
    @State private var scoreTitle:LocalizedStringKey = ""
    @State private var scoreNumber:Int = 0
    
    @State private var carlogoList = CarLogoCollection(sample: [CarLogo.defaultCarLogo])
    
    @State private var carlogos = ["audi","benz","bmw","citroen","ford","lexus","volvo"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
//        UINavigationBar.appearance().barTintColor = UIColor(navColor)
//        UINavigationBar.appearance().backgroundColor = UIColor(navColor)
    }
    
    var body: some View {
        NavigationView{
            
            ZStack {
                RadialGradient(stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
                
                
                VStack {
                    Spacer()
                    
//                    Text("Guess the Car Logo")
//                        .font(.largeTitle.bold())
//                        .foregroundColor(.white)
                    
                    VStack(spacing: 15) {
                        VStack {
                            Text("Tap the logo of")
                                .foregroundColor(.black)
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                            
                            Text(carlogos[correctAnswer].uppercased())
                                .font(.largeTitle.weight(.semibold))
                                .foregroundColor(.black)
                        }
                        
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(carlogos[number])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit) // 缩放比例
                                    .frame(width: 90, height: 90, alignment: .center) // 设置宽高
                                    .padding(10)
                                    .background(RoundedCorners(color: .white, tl: 20, tr: 20, bl: 20, br: 20))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 30)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Spacer()
                    Spacer()
                    
                    Text("Score: \(scoreNumber)")
                        .foregroundColor(.white)
                        .font(.title.bold())
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle(
                Text("Guess the Car Logo")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
//               , displayMode: .inline
            ).foregroundColor(.white)
            .navigationBarHidden(false)
//            navigationBarBackButtonHidden()
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(scoreNumber)")
                //            Text(String(localized: "\(selection.name)", table: "Categories", comment: "Category"))
            }
        }
    }
    
    func updateNavigationBarColor(textColor:Color,bgColor:Color) {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: textColor]
//            UINavigationBar.appearance().barTintColor = UIColor(themeColor)
        UINavigationBar.appearance().backgroundColor = UIColor(bgColor)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreNumber += 1
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
        GuessTheCarLogoView().environment(\.locale, .init(identifier: "zh-Hans"))
    }
}
