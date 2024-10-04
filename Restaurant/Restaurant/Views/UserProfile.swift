//
//  UserProfile.swift
//  Restaurant
//
//  Created by MainUser on 2/10/2024.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    
    @State var isShown: Bool = false
    
    // Fields
    let ogFirstName: String
    let ogLastName: String
    let ogEmail: String
    
    @State var curFirstName: String
    @State var curLastName: String
    @State var curEmail: String
    
    @State var isValid: Bool = false
    @State var validationError: String? = "No changes detected."
    @State var showChangedDetailsAlert: Bool = false
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack { userProfile }
        } else {
            NavigationView { userProfile }
        }
    }
    
    init() {
        self.ogFirstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
        self.ogLastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
        self.ogEmail = UserDefaults.standard.string(forKey: kEmail) ?? ""
        
        self.curFirstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
        self.curLastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
        self.curEmail = UserDefaults.standard.string(forKey: kEmail) ?? ""
    }
    
    @ViewBuilder
    private var userProfile: some View {
        ScrollView {
            Image("profile-image-placeholder")
                .resizable()
                .scaledToFit()
                .frame(width: 160)
            
            VStack {
                Text(ogFirstName)
                Text(ogLastName)
                Text(ogEmail)
            }
            .fontWeight(.medium)
            .font(.system(size: 24))
            
            
            LLMainButton("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                isShown = true
                self.presentation.wrappedValue.dismiss()
            }
            .alert("Logged out", isPresented: $isShown, actions: {
                Button("Ok") {
                    showChangedDetailsAlert = false
                }
            }, message: {
                Text("You will be logged out the next time you open the app.")
            })
            
            Rectangle()
                .frame(height: 5)
            
            editView
        }
        .navigationTitle("Personal Information")
    }
    
    @ViewBuilder
    private var editView: some View {
        Text("Edit details")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
        
        LLTextField("First Name*", text: $curFirstName) { _ in validateInput() }
            .padding()
        LLTextField("Last Name*", text: $curLastName) { _ in validateInput() }
            .padding()
        LLTextField("Email*", text: $curEmail) { _ in validateInput() }
            .padding()
        
        Text(validationError ?? "Updated Details appear valid.")
            .foregroundStyle(Color("Secondary 4"))
            .fontWeight(.bold)
            .font(.system(size: 20))
        
        LLMainButton("Change Details", isActive: $isValid) {
            UserDefaults.standard.set(curFirstName, forKey: kFirstName)
            UserDefaults.standard.set(curLastName, forKey: kLastName)
            UserDefaults.standard.set(curEmail, forKey: kEmail)
            
            showChangedDetailsAlert = true
        }
        .alert("Details updated", isPresented: $showChangedDetailsAlert, actions: {
            Button("Ok") {
                showChangedDetailsAlert = false
            }
        }, message: {
            Text("Your details will be updated the next time you open the app.")
        })
    }
    
    func validateInput() {
        if curFirstName == "" {
            validationError = "Please provide a first name."
            isValid = false
            return
        }
        if curLastName == "" {
            validationError = "Please provide a last name."
            isValid = false
            return
        }
        if curEmail == "" {
            validationError = "Please provide an email."
            isValid = false
            return
        }
        if (
            curFirstName == ogFirstName &&
            curLastName == ogLastName &&
            curEmail == ogEmail
        ) {
            validationError = "No changes detected."
            isValid = false
            return
        }
        
        isValid = true
        validationError = nil
    }
}

#Preview {
    UserProfile()
}
