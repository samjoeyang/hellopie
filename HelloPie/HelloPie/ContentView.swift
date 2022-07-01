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
    ]
    
    @State private var innerApps:[InnerAppsData] = [
        InnerAppsData(appName: "猜车标", bgColor: .pink, Content: { GuessTheCarLogoView() } ),
//        InnerAppsData(appName: "Test", bgColor: .red, Content: { ImageView() }),
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
//                        PushButton(title: "猜车标", bgColor: .pink, isOn: $showCarLogoView)
//                            .fullScreenCover(isPresented:$showCarLogoView,content: {
//                                GuessTheCarLogoView()
//                            })
//
//                        PushButton(title: "Test", bgColor: .pink, isOn: $showCarLogoView)
//                            .fullScreenCover(isPresented:$showCarLogoView,content: {
//                                CarLogoListView()
//                            })
                        
                        ForEach(innerApps.indices, id: \.self) { index in
                            PushButton(title: innerApps[index].appName, bgColor: allColors[index], isOn: $showCarLogoView)
                                .fullScreenCover(isPresented:$showCarLogoView,content: {
                                    innerApps[index].Content()
                                })
                        }
//                        ForEach(miniApps.indices, id: \.self) { index in
//
//                            PushButton(title: miniApps[index], bgColor: allColors[index], isOn: $showCarLogoView)
//                                .fullScreenCover(isPresented:$showCarLogoView,content: {
//                                    GuessTheCarLogoView()
//                                })
//                        }
                        
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
