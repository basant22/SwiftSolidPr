//
//  UserList.swift
//  SwiftSolidPr
//
//  Created by apple on 31/03/26.
//

import SwiftUI

struct UserList: View {
    @StateObject var viewModel = UserViewModel()
    @State private var isNext = false
    @Environment(\.dismiss) var dismiss
    // 1. Setup the Green Background Appearance
//        init() {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = .systemGreen // Your green background
//            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//            // Apply to all states
//            UINavigationBar.appearance().standardAppearance = appearance
//            UINavigationBar.appearance().scrollEdgeAppearance = appearance
//
//            // This makes the back button/chevron white
//            UINavigationBar.appearance().tintColor = .white
//        }
    var body: some View {
        GeometryReader { geometry in
            VStack{
//                ScrollView{
//
//                ForEach(viewModel.users,id:\.id){ user in
//                    LazyVStack(alignment: .leading) {
//                        Text(user.name).font(.headline)
//                        Text(user.email).font(.subheadline)
//                    }
//                    .frame( height: 60)
//                }
//                }
                List(viewModel.users, id: \.id) { user in
                    VStack(alignment: .leading) {
                        Text(user.name).font(.headline)
                        Text(user.email).font(.subheadline)
                    }
                    .frame( height: 60)
                    .onAppear{
                        if user.id == viewModel.users.last?.id{
                            viewModel.fetchUsers()
                        }
                    }
                }
                .refreshable {
                     viewModel.fetchUsers()
                }
                
                Text(viewModel.name)
                
                NavigationLink(
                    destination: ChangeName(viewModel: viewModel),
                    isActive: $isNext
                ) {
                    Button("Next"){
                        isNext = true
                    }
                    .frame(width: geometry.size.width*0.70, height: 50, alignment: .center)
                    .background(.blue)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    .padding([.top,.bottom], 20)
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
            }
            .onAppear {
               
                     viewModel.fetchUsers()
                
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.inline)
            // 2. Add the Left and Right Buttons
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                        // Custom back action or dismiss
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Settings", action: {})
                        Button("Logout", action: {})
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.white)
                    }
                }
            }
            
        }
    }
}

struct UserList_Previews: PreviewProvider {
    static var previews: some View {
        UserList()
    }
}
