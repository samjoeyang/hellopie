//
//  GuessTheCarLogoView.swift
//  HelloPie
//
//  Created by SamjoeYang on 2022/6/24.
//

import SwiftUI
import CoreData

struct GuessTheCarLogoView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<CarLogo>
    
    @State private var showNewView = false
    @State private var showEditView = false
    @State private var showAddView = false
    @State private var showDeleteView = false
    
    @State private var showingScore = false
    @State private var scoreTitle:LocalizedStringKey = ""
    @State private var scoreNumber:Int = 0
    
//    @State private var carlogoList = CarLogoDataCollection(sample: [CarLogo.defaultCarLogo])
    @State private var carlogoList: [CarLogoData] = [
        CarLogoData(en: "audi", cn: "奥迪", img: "audi"),
        CarLogoData(en: "benz", cn: "奔驰", img: "benz"),
        CarLogoData(en: "buick", cn: "别克", img: "buick"),
        CarLogoData(en: "bmw", cn: "宝马", img: "bmw"),
        CarLogoData(en: "citroen", cn: "雪铁龙", img: "citroen"),
        CarLogoData(en: "ford", cn: "福特", img: "ford"),
        CarLogoData(en: "lexus", cn: "雷克萨斯", img: "lexus"),
        CarLogoData(en: "volvo", cn: "沃尔沃", img: "volvo"),
        CarLogoData(en: "chevrolet", cn: "雪弗兰", img: "chevrolet"),
        CarLogoData(en: "dazhong", cn: "大众", img: "dazhong"),
        CarLogoData(en: "honda", cn: "本田", img: "honda"),
        CarLogoData(en: "hyundai", cn: "现代", img: "hyundai"),
        CarLogoData(en: "kia", cn: "起亚", img: "kia"),
        CarLogoData(en: "mazda", cn: "马自达", img: "mazda"),
        CarLogoData(en: "mitsubishi", cn: "三菱", img: "mitsubishi"),
        CarLogoData(en: "nissan", cn: "尼桑", img: "nissan"),
        CarLogoData(en: "peugeot", cn: "标致", img: "peugeot"),
        CarLogoData(en: "renault", cn: "雷诺", img: "renault"),
        CarLogoData(en: "skoda", cn: "斯科达", img: "skoda"),
        CarLogoData(en: "smart", cn: "Smart", img: "smart"),
        CarLogoData(en: "subaru", cn: "斯巴鲁", img: "subaru"),
        CarLogoData(en: "suzuki", cn: "铃木", img: "suzuki"),
        CarLogoData(en: "toyota", cn: "丰田", img: "toyota"),
    ].shuffled()
    
//    @State private var carlogos = ["audi","benz","bmw","citroen","ford","lexus","volvo"].shuffled()
    
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
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
//                    .init(color: Color(red: 1.0, green: 1.0, blue: 1.0), location: 0.4),
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
                            //                                .foregroundColor(.black)
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                            
                            Text(carlogoList[correctAnswer].cnName.uppercased())
                                .font(.largeTitle.weight(.semibold))
                            //                                .foregroundColor(.black)
                        }
                        
                        ForEach(0..<3) { number in
                            
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(carlogoList[number].img)
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
            .navigationTitle("Guess the Car Logo")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarHidden(true)
            //            navigationBarBackButtonHidden()
            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink{
//                        CarLogoListView().environment(\.managedObjectContext, self.moc)
//                            .navigationBarHidden(true)
//                    } label: {
//                        Text("Edit")
//                    }
//                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Label("Back", systemImage: "chevron.backward")
                    }
                }
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
        carlogoList.shuffle()
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
    
    @Environment(\.dismiss) var dismiss
    
    @State private var itemIndex:Int = 0
    @State private var itemsList = [Int]()
    
    @State private var isShowSheetView=false
    let decoder = JSONDecoder()
    
    var body: some View {
        NavigationView {
//            List(carlogolist) { carlogo in
//                    Text(carlogo.enName ?? "Unknown")
//                    Text(carlogo.cnName ?? "Unknown")
//                    Text(carlogo.img ?? "Unknown")
//                }
            List  {
                
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

                ForEach(carlogolist,id:\.self) { carlogo in
                    NavigationLink {
                        CarLogoDetailView(carlogo: carlogo)
                    } label: {
                        HStack {
                            //                            EmojiRatingView(rating: book.rating)
                            //                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(carlogo.cnName ?? "Unknown")
                                    .font(.headline)
                                
                                Text(carlogo.enName ?? "Unknown")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
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
                        CarLogoAddView()
                    }
                    
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Label("Back", systemImage: "chevron.backward")
                    }
                }
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
//        itemsList.remove(atOffsets: offsets)
//        if itemsList.count == 0 {
//            itemIndex = 0
//        } else {
//            itemIndex -= 1
//        }
        
        for offset in offsets {
            let row = carlogolist[offset]
            moc.delete(row)
        }
//        try? moc.save()
    }
}

//struct CarLogoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarLogoListView()
//            .environment(\.locale, .init(identifier: "zh-Hans"))
//    }
//}

struct CarLogoAddView:View{
//    @ObservedObject var data:CarLogosData
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    @State private var enName = ""
    @State private var cnName = ""
    @State private var img    = ""
    @State private var description    = ""
    
    @State private var showingImagePicker:Bool=false
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    let context = CIContext()
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("English Name", text:$enName)
                    TextField("Chinese Name", text:$cnName)
                }
                Section ("Select a picture") {
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .opacity(0.3)
                            .frame(width:200,height: 200, alignment: .center)

                        Text("Tap to select a picture")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                            .shadow(radius: 10)

                        image?
                            .resizable()
                            .scaledToFit()
                            .frame(width: .infinity, height: 200, alignment: .center)
                    }
                    .padding(0)
                    .frame(width: .infinity,height:200, alignment: .center)
                    .onTapGesture {
                        showingImagePicker = true
                    }
                    
                }
                .padding(0)
                .onChange(of: inputImage) { _ in loadImage() }
                .sheet(isPresented: $showingImagePicker,onDismiss: loadImage) {
                    ImagePicker(image: $inputImage)
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
                        
                        let newcarlogo = CarLogo(context: self.moc)
                        newcarlogo.enName = trimmedEn
                        newcarlogo.cnName = trimmedCn
                        newcarlogo.img    = self.img
                        
                        saveImage()
                        
                        try? self.moc.save()

//                        let newcarlogo2 = CarLogoData(en:trimmedEn,cn:trimmedCn,img: img)
//                        data.carlogos.append(newcarlogo2)
                        
                        self.presentationMode.wrappedValue.dismiss()
//                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }

        image = Image(uiImage: inputImage)
    }
    func saveImage() {
//        let imageSaver = ImageSaver()
//        imageSaver.writeToPhotoAlbum(image: inputImage)
//        -----------------
//        do {
//            let url = getDocumentsDirectory().appendingPathComponent("message.txt")
//            try data.write(to: url, atomically:true,encoding:.utf8)
//            let input = try String(contentsOf: url)

//            let data = try JSONEncoder().encode(locations)
//            let data = inputImage?.jpegData(compressionQuality: 1.0)
//            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
//        } catch {
//            print("Unable to save data.")
//        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct CarLogoDetailView: View {
    let carlogo: CarLogo
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(carlogo.img ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(carlogo.enName?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(carlogo.cnName ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)
            
//            Text(carlogo.description ?? "No review")
//                .padding()
            
//            RatingView(rating: .constant(Int(book.rating)))
//                .font(.largeTitle)
        }
        .navigationTitle(carlogo.enName ?? "Unknown Logo")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete item?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: removeItem)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    func removeItem() {
        moc.delete(carlogo)
        dismiss()
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//            .environment(\.locale, .init(identifier: "zh-Hans"))
//    }
//}
