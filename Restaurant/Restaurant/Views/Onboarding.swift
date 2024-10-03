//
//  Onboarding.swift
//  Restaurant
//
//  Created by MainUser on 2/10/2024.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    @State var searchPlaceholder = ""
    
    var body: some View {
        if #unavailable(iOS 18.0) {
            NavigationStack { onboardingForm }
        } else {
            NavigationView { onboardingForm }
        }
    }
    
    @ViewBuilder
    var onboardingForm: some View {
        VStack {
            Hero(searchText: $searchPlaceholder, onChange: {_ in }, showSearch: false)
            NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                EmptyView()
            }
            
            VStack {
                LLTextField("First Name*", text: $firstName)
                    .padding(.bottom)
                LLTextField("Last Name*", text: $lastName)
                    .padding(.bottom)
                LLTextField("Email*", text: $email)
                    .padding(.bottom)
            }
            .padding()
            
            
            LLMainButton("Register") {
                
                // Check that the fields are not empty
                if (firstName.isEmpty || lastName.isEmpty ||
                    email.isEmpty) { return } else {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        
                        isLoggedIn = true
                }
            }
        }
        .onAppear {
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) == true {
                isLoggedIn = true
            }
        }
    }
}

#Preview {
    Onboarding()
}
