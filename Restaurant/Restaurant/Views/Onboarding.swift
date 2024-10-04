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
    
    @State var isValid = false
    @State var validationError: String? = "Please enter your personal details."
    
    var body: some View {
        if #unavailable(iOS 18.0) {
            NavigationStack { onboardingForm }
        } else {
            NavigationView { onboardingForm }
        }
    }
    
    @ViewBuilder
    var onboardingForm: some View {
        ScrollView {
            MenuBar()
            Hero(searchText: $searchPlaceholder, onChange: {_ in }, showSearch: false)
            NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                EmptyView()
            }
            
            VStack {
                LLTextField("First Name*", text: $firstName) { _ in validateInput()}
                    .padding(.bottom)
                LLTextField("Last Name*", text: $lastName) { _ in validateInput()}
                    .padding(.bottom)
                LLTextField("Email*", text: $email) { _ in validateInput()}
                    .padding(.bottom)
            }
            .padding()
            
            Text(validationError ?? "Data seems valid.")
                .foregroundStyle(Color("Secondary 4"))
                .fontWeight(.bold)
                .font(.system(size: 20))
            
            LLMainButton("Register", isActive: $isValid) {
                
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
    init(firstName: String = "", lastName: String = "", email: String = "", isLoggedIn: Bool = false, searchPlaceholder: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.isLoggedIn = isLoggedIn
        self.searchPlaceholder = searchPlaceholder
    }
    
    func validateInput() {
        if firstName == "" {
            validationError = "Please provide a first name."
            isValid = false
            return
        }
        if lastName == "" {
            validationError = "Please provide a last name."
            isValid = false
            return
        }
        if email == "" {
            validationError = "Please provide an email."
            isValid = false
            return
        }
        
        isValid = true
        validationError = nil
    }
}

#Preview {
    Onboarding()
}
