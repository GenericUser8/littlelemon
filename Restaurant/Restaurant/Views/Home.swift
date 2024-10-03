//
//  Home.swift
//  Restaurant
//
//  Created by MainUser on 2/10/2024.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        MenuBar()
        if #available(iOS 18.0, *) {
            TabView {
                Tab("Menu", systemImage: "list.dash") {
                    Menu()
                        .environment(\.managedObjectContext, persistence.container.viewContext)
                }
                Tab("Profile", systemImage: "square.and.pencil") {
                    UserProfile()
                }
            }
            .navigationBarBackButtonHidden(true)
        } else {
            TabView {
                Menu()
                    .environment(\.managedObjectContext, persistence.container.viewContext)
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                UserProfile()
                    .tabItem {
                        Label("Profile", systemImage: "square.and.pencil")
                    }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    Home()
    // Provide basic user details for testing
        .onAppear {
            UserDefaults.standard.set("John", forKey: kFirstName)
            UserDefaults.standard.set("Smith", forKey: kLastName)
            UserDefaults.standard.set("johnsmith@mail.com", forKey: kEmail)
        }
}
