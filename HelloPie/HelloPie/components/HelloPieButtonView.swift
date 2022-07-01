//
//  HelloPieButtonView.swift
//  HelloPie
//
//  Created by SamjoeYang on 2022/7/1.
//

import SwiftUI

//struct PushButton<gotoView:View>: View {
struct PushButton: View {
    let title: String
    var bgColor: Color
    @Binding var isOn: Bool
    
//    var gotoView:() -> gotoView

//    var onColors:[Color] = [
//        .pink,
//        .red,
//        .orange,
//        .yellow,
//        .green,
//        .mint,
//        .teal,
//        .cyan,
//        .blue,
//        .indigo,
//        .purple,
//        .brown,
//        .gray
//    ]
//    var onColors = [Color.red, Color.yellow]
//    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button {
            self.isOn.toggle()
        } label: {
            Text(title)
                .font(.title3.weight(.heavy))
                .foregroundColor(.white)
                .padding(0)
                .shadow(radius: 3)
        }
//        Button(title) {
//            self.isOn.toggle()
//        }
        .padding()
//        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .background(bgColor)
        .foregroundColor(.white)
        .frame(width: 80, height: 80, alignment: .center)
        .cornerRadius(15)
        .buttonStyle(.plain)
//        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
//        .fullScreenCover(isPresented:$isOn,content: {
//            gotoView
//        })
        .onTapGesture {
            isOn = true
        }
    }
}

//struct PushButton_Previews: PreviewProvider {
//    static var previews: some View {
//        PushButton(title: "test", bgColor: Color.red, isOn: false)
//            .fullScreenCover(isPresented:true,content: {
//                CarLogoListView()
//            })
//    }
//}
struct ParentView<ChildView:View>:View{
    var childView:() -> ChildView
    
    let title:String
    
    var body: some View{
        Text(title)
        childView()
    }
}

struct HelloPieButtonView: View {
    @State private var isShow:Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            PushButton(title: "test2", bgColor: Color.red, isOn: $isShow)
                .fullScreenCover(isPresented:$isShow,content: {
                    CarLogoListView()
                })
            
            Spacer()
            
            ParentView(childView:{Text("我是childView")},title:"dhfkg")
            Spacer()
        }
    }
}

struct HelloPieButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HelloPieButtonView()
    }
}
