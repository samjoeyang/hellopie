//
//  ContentView.swift
//  HelloPie
//
//  Created by SamjoeYang on 2022/6/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showCarLogoView:Bool=false
    
    let columnLayout = Array(repeating: GridItem(), count: 3)
    
    @State private var selectedColor=Color.gray
    
    let allColors:[Color] = [
        .pink,
        .red,
        .orange,
        .yellow,
        .green,
        .mint,
        .teal,
        .cyan,
        .blue,
        .indigo,
        .purple,
        .brown,
        .gray
    ]
    let miniApps:[String] = [
        "猜车标",
        "猜车标",
        "猜车标猜车标",
        "猜车标猜车标猜车标猜车标",
    ]
    
    
    var body: some View {

            VStack(alignment: .leading) {
                Text("Hello Pie!")
                    .foregroundColor(.orange)
                    .font(.largeTitle.bold())
                    .shadow(radius: 5)
                    .padding(10)
                
                ScrollView {
                    LazyVGrid(columns: columnLayout) {
    //                    ForEach(allColors.indices, id: \.self) { index in
    //                        Button {
    //                            selectedColor = allColors[index]
    //                        } label: {
    //                            RoundedRectangle(cornerRadius: 4.0)
    //                                .aspectRatio(1.0, contentMode: ContentMode.fit)
    //                                .foregroundColor(allColors[index])
    //                        }
    //                        .buttonStyle(.plain)
    //                    }
                        
                        
                        ForEach(miniApps.indices, id: \.self) { index in
                            Button {
                                showCarLogoView.toggle()
                            }label: {
                                Text(miniApps[index])
                                    .font(.title3.weight(.heavy))
                                    .foregroundColor(.white)
                                    .padding(0)
                                    .shadow(radius: 3)
                            }
                            .frame(width: 80, height: 80, alignment: .center)
                            .background(allColors[index])
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .buttonStyle(.plain)
                            .fullScreenCover(isPresented:$showCarLogoView,content: {
                                GuessTheCarLogoView()
                            }).onTapGesture {
                                showCarLogoView = true
                            }
                        }
                        
                    }
                    
                }
                
            }
            .padding(10)
    }
}

//struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
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
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
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
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, .init(identifier: "zh-Hans"))
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
