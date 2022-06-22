//
//  ContentView.swift
//  HelloPieApp
//
//  Created by Samjoe Yang on 2022/6/21.
//

import SwiftUI
//import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
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
    ]
    var body: some View {
        
        /*#-code-walkthrough(2.body)*/
        /*#-code-walkthrough(2.vStack)*/
        VStack {
            Text("Hello Pie!")
            
            ScrollView {
                /*#-code-walkthrough(2.scrollView)*/
                /*#-code-walkthrough(2.lazyVGrid)*/
                LazyVGrid(columns: columnLayout) {
                    /*#-code-walkthrough(2.lazyVGrid)*/
                    /*#-code-walkthrough(2.gridForEach)*/
                    //                    ForEach(allColors.indices, id: \.self) { index in
                    //                        /*#-code-walkthrough(2.gridForEach)*/
                    //                        /*#-code-walkthrough(2.gridElement)*/
                    //                        Button {
                    //                            /*#-code-walkthrough(3.colorChange)*/
                    //                            selectedColor = allColors[index]
                    //                            /*#-code-walkthrough(3.colorChange)*/
                    //                        } label: {
                    //                            /*#-code-walkthrough(2.gridLabel)*/
                    //                            RoundedRectangle(cornerRadius: 4.0)
                    //                                .aspectRatio(1.0, contentMode: ContentMode.fit)
                    //                                .foregroundColor(allColors[index])
                    //                            /*#-code-walkthrough(2.gridLabel)*/
                    //                        }
                    //                        .buttonStyle(.plain)
                    //                        /*#-code-walkthrough(2.gridElement)*/
                    //                    }
                    ForEach(miniApps.indices, id: \.self) { index in
                        Button{
                            
                        } label: {
                            Text(miniApps[index])
                                .font(.title3.weight(.heavy))
                                .foregroundColor(.white)
                                .padding(20)
                        }
//                        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                        .background(allColors[index])
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .buttonStyle(.plain)
                    }
                }
            }
            .navigationTitle("Hello,Pie")
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
        ContentView().environment(\.locale, .init(identifier: "zh-Hans"))
        //            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
