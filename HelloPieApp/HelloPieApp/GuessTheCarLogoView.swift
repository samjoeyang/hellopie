//
//  GuessTheCarLogoView.swift
//  HelloPieApp
//
//  Created by Samjoe Yang on 2022/6/21.
//

import SwiftUI
import CoreData


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
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var showNewView = false
    @State private var showEditView = false
    @State private var showAddView = false
    @State private var showDeleteView = false
    
    @State private var showingScore = false
    @State private var scoreTitle:LocalizedStringKey = ""
    @State private var scoreNumber:Int = 0
    
//    @State private var carlogoList = CarLogoCollection(sample: [CarLogo.defaultCarLogo])
    
    @State private var carlogos = ["audi","benz","bmw","citroen","ford","lexus","volvo"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
//    init() {
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
//        UINavigationBar.appearance().barTintColor = UIColor(navColor)
//        UINavigationBar.appearance().backgroundColor = UIColor(navColor)
//    }
    
    var body: some View {
        NavigationView{
            
            ZStack {
                RadialGradient(stops: [
                    //                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 1.0, green: 1.0, blue: 1.0), location: 0.3),
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
                            //                                .foregroundColor(.black)
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                            
                            Text(carlogos[correctAnswer].uppercased())
                                .font(.largeTitle.weight(.semibold))
                            //                                .foregroundColor(.black)
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
            .navigationTitle(
                Text("Guess the Car Logo")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                //               , displayMode: .inline
            )
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarHidden(false)
            //            navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink{
                        CarLogoListView().environment(\.managedObjectContext, self.moc)
                    } label: {
                        Text("Edit")
                    }
//                    Button(action: {showEditView = true}) {
//                        Label("Edit", systemImage: "square.and.pencil")
//                    }
//                    .fullScreenCover(isPresented:$showEditView,content: {
//                        CarLogoListView()
//                    }).onTapGesture {
//                        showEditView = true
//                    }
                    
                }
                //                ToolbarItem {
                //                    EditButton()
                //                }
            }
            //            .navigationBarItems(
            //                leading: {
            //                    Menu {
            //                        Button(action: {showAddView.toggle()}) {
            //                            Label("Add", systemImage: "plus")
            //                        }
            //                        Button(action: {showDeleteView.toggle()}) {
            //                            Label("Delete", systemImage: "trash")
            //                        }
            //                    } label: {
            //                        Image(systemName: "plus")
            //                    }
            //                }(),
            //                trailing: {
            //                    Button(action: {showEditView.toggle()}) {
            //                        Label("Edit", systemImage: "square.and.pencil")
            //                    }
            //                    Menu {
            //                        Button(action: {showNewView.toggle()}) {
            //                            Label("New", systemImage: "pencil")
            //                        }
            //                        Button(action: {showEditView.toggle()}) {
            //                            Label("Edit", systemImage: "square.and.pencil")
            //                        }
            //                    } label: {
            //                        Image(systemName: "ellipsis.circle")
            //                    }
            //                }()
            //
            //            )
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(scoreNumber)")
                //                Text(String(localized: "\(selection.name)", table: "Categories", comment: "Category"))
            }
            
            WelcomeView()
        }
        .phoneOnlyNavigationView()
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
    
    private func editItems() {
        //        withAnimation {
        //            let newItem = Item(context: viewContext)
        //            newItem.timestamp = Date()
        //
        //            do {
        //                try viewContext.save()
        //            } catch {
        //                // Replace this implementation with code to handle the error appropriately.
        //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        //                let nsError = error as NSError
        //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        //            }
        //        }
    }
}

struct GuessTheCarLogoView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheCarLogoView().environment(\.locale, .init(identifier: "zh-Hans"))
        //            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}


struct CarLogoListView:View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
//        NSSortDescriptor(keyPath: \CarLogosTable.enName, ascending: true),
//        NSSortDescriptor(keyPath: \CarLogosTable.cnName, ascending: true),
//        NSSortDescriptor(keyPath: \CarLogosTable.img, ascending: true),
        SortDescriptor(\.enName),
        SortDescriptor(\.cnName),
        SortDescriptor(\.img)
    ]) var carlogolist: FetchedResults<CarLogo>

    @State private var itemIndex:Int = 0
    @State private var itemsList = [Int]()
    
    @State private var isShowSheetView=false
    let decoder = JSONDecoder()
    
    var body: some View {
        NavigationView {
//            List(students) { student in
//                    Text(student.name ?? "Unknown")
//                }
            List  {
                //                NavigationLink{
                //
                //                } label: {
                //                    HStack {
                //                        Image(systemName: "plus")
                //                        Text("Add")
                //                        Spacer()
                //
                //                    }
                //                }
                Section {
                    
                    //                    if isLogin == false {
                    //                        Button("Login") {
                    //                            isShowSheetView.toggle()
                    //                        }
                    //                        .sheet(isPresented: $isShowSheetView) {
                    //                            LoginView()
                    //                        }
                    //                    } else {
                    //                        Text("Login Info: \(storeUser.username)")
                    //                        Button("Logout") {
                    //                            UserDefaults.standard.removeObject(forKey: "UserData")
                    //                            username = ""
                    //
                    //                            isLogin=false
                    //                        }
                    //                    }
                    
                    NavigationLink{
                        Text("NavigationLink Content")
                    } label:{
                        Text("NavigationLink")
                            .padding(0)
                    }
                }
                
//                Button("Add Item [Count:\(String(itemsList.count))]") {
//                    itemsList.append(itemIndex)
//                    itemIndex += 1
//                }
                ForEach(itemsList,id:\.self) {
                    Text("Row \($0)")
                }
                .onDelete(perform: removeRows)
            }
            .navigationTitle("CarLogo List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {isShowSheetView.toggle()}) {
                        Label("Add", systemImage: "plus.circle")
                    }
                    .sheet(isPresented: $isShowSheetView) {
                        AddCarLogoContentView()
                    }

                }
            }
        }
    }
    
    private func addItem() {
        
        
    }
    func removeRows(at offsets: IndexSet) {
        itemsList.remove(atOffsets: offsets)
        if itemsList.count == 0 {
            itemIndex = 0
        } else {
            itemIndex -= 1
        }
    }
}

struct CarLogoListView_Previews: PreviewProvider {
    static var previews: some View {
        CarLogoListView()
            .environment(\.locale, .init(identifier: "zh-Hans"))
    }
}

struct AddCarLogoContentView:View{
    //    @ObservedObject var data:CarLogos
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    
    @Environment(\.dismiss) var dismiss
    
    @State private var enName = ""
    @State private var cnName = ""
    @State private var img    = ""
    @State private var description    = ""
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("English Name", text:$enName)
                    TextField("Chinese Name", text:$cnName)
                }
                Section {
                    TextField("Car Logo image", text:$img)
                }
                Section (
                    content:{
                        TextEditor(text: $description)
                    },
                    header:{
                        Text("Description")
                    }
                )
                
            }
            .navigationTitle("Add Car Logo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        let trimmedEn=self.enName.trimmingCharacters(in:.whitespaces)
                        guard trimmedEn.isEmpty == false else { return }
                        
                        let trimmedCn=self.cnName.trimmingCharacters(in:.whitespaces)
                        guard trimmedCn.isEmpty == false else { return }
                        
//                        let newcarlogo = CarLogo(context: self.moc)
//                        newcarlogo.enName = trimmedEn
//                        newcarlogo.cnName = trimmedCn
//                        newcarlogo.img    = self.img
//
//                        try? self.moc.save()
                        
//                        let carlogo = CarLogo(en:trimmedEn,cn:trimmedCn,img: img)
//                        print(carlogo)
                        //                    data.carlogos.append(carlogo)
                        
//                        dismiss()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
//                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
//struct AddCarLogoContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCarLogoContentView()
//            .environment(\.locale, .init(identifier: "zh-Hans"))
//    }
//}
