//
//  ContentView.swift
//  HelloPie
//
//  Created by SamjoeYang on 2022/5/27.
//

import SwiftUI

struct ContentView: View {
    @State private var username : String = ""
    @State private var password : String = ""
//    @FocusState private var emailFieldIsFocused = false
    @State private var nameComponents = PersonNameComponents()
    @State private var isShowSheetView: Bool = false
    @State private var showNewView: Bool = false
    @State private var showEditView: Bool = false
    @State private var showAddView: Bool = false
    @State private var showDeleteView: Bool = false
    @State private var isLogin: Bool = false
    @State private var storeUser=UserData()
    
    @State private var itemIndex:Int = 0
    @State private var itemsList = [Int]()
    let decoder = JSONDecoder()
    
    var body: some View {
        NavigationView{
//            ScrollView{
//                VStack {
//                    GeometryReader { geo in
//                        Image(systemName: "ellipsis.circle")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width:geo.size.width * 0.5)
//                            .frame(width:geo.size.width,height: geo.size.height)
//                    }
//                }
                VStack {
                    
                    List{
                        Section {
                           
                            if isLogin == false {
                                Button("Login") {
                                    isShowSheetView.toggle()
                                }
                                .sheet(isPresented: $isShowSheetView) {
                                    LoginView()
                                }
                            } else {
                                Text("Login Info: \(storeUser.username)")
                                Button("Logout") {
                                    UserDefaults.standard.removeObject(forKey: "UserData")
                                    username = ""
                                    
                                    isLogin=false
                                }
                            }
                            
                            NavigationLink{
                                Text("NavigationLink Content")
                            } label:{
                                Text("NavigationLink")
                                    .padding(0)
//                                    .font(.title)
                            }
                        }
                        
                        Button("Add Item [Count:\(String(itemsList.count))]") {
                            itemsList.append(itemIndex)
                            itemIndex += 1
                        }
                        ForEach(itemsList,id:\.self) {
                            Text("Row \($0)")
                        }
                        .onDelete(perform: removeRows)
                    }
                }
                .onAppear {
                    print(isLogin)
                    if let userdata = UserDefaults.standard.data(forKey: "UserData") {
                        if let user = try? decoder.decode(UserData.self,from: userdata) {
                            storeUser = user
                            username = user.username
                            isLogin = true
                            print(user)
                        }
                    }
                }
                .onDisappear {
                    UserDefaults.standard.removeObject(forKey: "UserData")
                }
//        } // End of ScrollView
            
                // 编辑按钮
                .toolbar {
                    EditButton()
                }
                
                .navigationBarTitle("HelloPie")
                .navigationBarItems(
                    leading: {
                        Menu {
                            Button(action: {showNewView.toggle()}) {
                                Label("New", systemImage: "pencil")
                            }
                            Button(action: {showEditView.toggle()}) {
                                Label("Edit", systemImage: "square.and.pencil")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }(),
                    trailing: {
                        Menu {
                            Button(action: {showAddView.toggle()}) {
                                Label("Add", systemImage: "plus")
                            }
                            Button(action: {showDeleteView.toggle()}) {
                                Label("Delete", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    }()
                )
            }

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, .init(identifier: "zh-Hans"))
    }
}

// Example about Activity
struct ActivityContentView :View {
    @StateObject var data = Activities()
    @State private var addingNewActivity = false
    
    var body: some View {
        NavigationView{
            
            List (data.activities) { activity in
                NavigationLink{
                    ActivityDetailContentView(data:data,activity:activity)
                    
                } label: {
                    HStack {
                        Text(activity.title)
                        Spacer()
                        Text(String(activity.completionCount))
                    }
                }
            }
            .navigationTitle("Habito")
            .toolbar {
                Button {
                    addingNewActivity.toggle()
                    
                } label: {
                    Label("Add new activity", systemImage:"plus")
                }
            }
            .sheet(isPresented:$addingNewActivity){
                AddActivityContentView(data:data)
            }
        }
    }
    
    func color(for activity: Activity)-> Color{
        if activity.completionCount<3{
            return .red
        } else if activity.completionCount<10{
            return .orange
        } else if activity.completionCount<20{
            return .green
        } else if activity.completionCount<50{
            return.blue
        } else {
            return .indigo
        }
        
    }
}
struct ActivityContentView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityContentView()
            .environment(\.locale, .init(identifier: "zh-Hans"))
    }
}


struct AddActivityContentView:View{
    @ObservedObject var data:Activities
    @State private var title = ""
    @State private var description = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Title", text:$title)
                TextField("Description", text:$description)
                
            }
            .navigationTitle("Add Activity")
            .toolbar {
                Button("Save"){
                    let trimmedTitle=title.trimmingCharacters(in:.whitespaces)
                    guard trimmedTitle.isEmpty == false else { return }
                    let activity = Activity(title:trimmedTitle,description: description)
                    data.activities.append(activity)
                    
                    dismiss()
                    
                }
            }
        }
    }
}


struct ActivityDetailContentView: View {
    @ObservedObject var data : Activities
    var activity: Activity
    
    var body: some View {
        List {
            Section {
                if activity.description.isEmpty==false {
                    Text(activity.description)
                }
            }
            Section {
                Text("Completion count:\(activity.completionCount)")
                Button("Mark Completed"){
                    // More code to come
                    var newActivity=activity
                    newActivity.completionCount+=1
                    if let index=data.activities.firstIndex(of:activity) {
                        data.activities[index]=newActivity
                    }
                }
            }
        }
        .navigationTitle(activity.title)

    }
}
//struct ActivityDetailContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityDetailContentView(data: Activities(), activity: Activity.example)
//            .environment(\.locale, .init(identifier: "zh-Hans"))
//    }
//}
