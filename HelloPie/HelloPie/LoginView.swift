////
////  LoginView.swift
////  HelloPie
////
////  Created by SamjoeYang on 2022/5/27.
////
//
//
//import SwiftUI
//
//struct LoginView: View {
//
////    @StateObject var userinfo = UserDataCollection(sample: <#T##[UserData]#>)
//    @State private var userinfo: UserData?
//    
//    @State private var username : String = ""
//    @State private var password : String = ""
//
//    @FocusState private var emailFieldIsFocused: Bool
//    @State private var nameComponents = PersonNameComponents()
//
//    @State private var showAlert: Bool = false
//
//    enum loginError: Error {
//        case short, obvious, mobileisEmpty
//    }
//
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        NavigationView {
//            Form{
//                Section {
//                    TextField(
//                        "Mobile",
//                        text: $username
//                        )
//                        .focused($emailFieldIsFocused)
//                        .onSubmit {
////                            validate(name: username)
//                        }
//                        .textInputAutocapitalization(.never)
//                        .disableAutocorrection(true)
////                        .border(.secondary)
//
//                    SecureField(text: $password,
//                                prompt: Text("Password")) {
//                                    Text("Password")
//                                }
//
//                } header: {
//                    Text("")
////                    Text("Mobile and Password")
//                }
//
////                Section {
////                    TextField(
////                            "Proper name",
////                            value: $nameComponents,
////                            format: .name(style: .medium)
////                        )
////                        .onSubmit {
////    //                        validate(components: nameComponents)
////                        }
////                        .disableAutocorrection(true)
////    //                    .border(.secondary)
////                    Text(nameComponents.debugDescription)
////                }
//
//                Button("Login") {
//                    let encoder = JSONEncoder()
//
//                    let user = UserData(username:username, password:password)
//
//                    if let userdata = try? encoder.encode(user) {
//                        UserDefaults.standard.set(userdata,forKey: "UserData")
//                    }
////                    showAlert.toggle()
//                    dismiss()
//                }
//                .disabled(username.isEmptyEx || password.isEmptyEx)
//
//            }
//            .navigationTitle("Login")
//            .navigationBarItems(trailing: {
//                Button("Cancel") {
//                    dismiss()
//                }
//            }())
////            .alert("AlertTitle", isPresented: $showAlert) {
////                Button("OK") {}
////            } message: {
////                Text("Mobile is \(username) \n  Password is \(password)")
////
////            }
//
//        }
//        .ignoresSafeArea()
//    }
//
//    func validate(mobile: String) throws -> Bool {
//        if mobile == "" {
//            throw loginError.mobileisEmpty
//        }
//        return true
//    }
//
//}
//
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//            .environment(\.locale, .init(identifier: "zh-Hans"))
//    }
//}
//
