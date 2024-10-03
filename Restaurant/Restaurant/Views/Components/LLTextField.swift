//
//  LLTextField.swift
//  Restaurant
//
//  Created by MainUser on 3/10/2024.
//

import SwiftUI

struct LLTextField: View {
    var text: Binding<String>
    var placeholder: String = ""
    var label: String = ""
    
    var onChange: Optional<(String)->()>
    
    init(_ placeholder: String, text: Binding<String>, label: String? = nil, onChange: Optional<(String)->()> = nil) {
        
        if let label = label {
            self.label = label
        } else {
            self.label = placeholder
        }
        
        self.text = text
        self.placeholder = placeholder
        self.onChange = onChange
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(label)
                    .foregroundStyle(Color("Secondary 4"))
                    .font(.system(size: 20))
                    .padding(.bottom, -5)
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .foregroundStyle(Color("Secondary 3"))
                RoundedRectangle(cornerRadius: 9)
                    .frame(height: 45)
                    .foregroundStyle(.white)
                    .padding([.leading, .trailing], 2.5)
                TextField(placeholder, text: text)
                    .font(.system(size: 20))
                    .padding([.leading, .trailing])
                    .onChange(of: text.wrappedValue) { text in
                        guard let onChange = onChange else { return }
                        onChange(text)
                    }
            }
        }
    }
}

#Preview {
    StateContainer()
}
fileprivate struct StateContainer: View {
    @State var nameState: String = ""
    @State var emailState: String = ""
    
    var body: some View {
        LLTextField("Name", text: $nameState)
            .padding()
        LLTextField("Email", text: $emailState)
            .padding()
    }
}
