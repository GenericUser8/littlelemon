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
        if #unavailable(iOS 18.0) {
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
}
