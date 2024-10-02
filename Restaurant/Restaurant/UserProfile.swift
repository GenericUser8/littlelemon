//
//  UserProfile.swift
//  Restaurant
//
//  Created by MainUser on 2/10/2024.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
            
            Text(UserDefaults.standard.string(forKey: kFirstName) ?? "")
            Text(UserDefaults.standard.string(forKey: kLastName) ?? "")
            Text(UserDefaults.standard.string(forKey: kEmail) ?? "")
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
