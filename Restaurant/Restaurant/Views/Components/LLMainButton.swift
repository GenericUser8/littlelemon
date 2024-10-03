//
//  LLMainButton.swift
//  Restaurant
//
//  Created by MainUser on 4/10/2024.
//

import SwiftUI

struct LLMainButton: View {
    let buttonText: String
    var isActive: Binding<Bool>?
    let tapHandler: ()->()
    
    var status: Bool {
        guard let isActive = isActive else { return true }
        return isActive.wrappedValue
    }
    
    init(_ buttonText: String, isActive: Binding<Bool>? = nil, onTapGesture: @escaping ()->()) {
        self.buttonText = buttonText
        self.isActive = isActive
        self.tapHandler = onTapGesture
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(status ? Color("Primary 2") : Color("Secondary 3"))
                .frame(height: 60)
                .animation(.default, value: status)
            Text(buttonText)
                .font(.system(size: 24))
                .foregroundStyle(status ? Color("Primary 1") : Color("Secondary 4"))
                .fontWeight(.bold)
                .animation(.default, value: status)
        }
        .padding()
        .onTapGesture {
            guard status else { return }
            
            tapHandler()
        }
    }
}

#Preview {
    StateContainer()
}
fileprivate struct StateContainer: View {
    @State var isActive: Bool = true
    
    var body: some View {
        LLMainButton("Button Text", isActive: $isActive) {
            print("Tapped")
        }
        Button("Toggle isActive") {
            isActive.toggle()
        }
    }
}
