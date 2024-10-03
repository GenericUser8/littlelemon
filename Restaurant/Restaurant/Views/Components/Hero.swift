//
//  Hero.swift
//  Restaurant
//
//  Created by MainUser on 3/10/2024.
//

import SwiftUI

struct Hero: View {
    @Binding var searchText: String
    var onChange: (String) -> () = {_ in }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color("Primary 1"))
            VStack {
                HStack {
                    Text("Little Lemon")
                        .font(.custom("Times New Roman", size: 40))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("Primary 2"))
                        .padding()
                    Spacer()
                }
                Text("""
We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.
""")
                .foregroundStyle(Color("Secondary 3"))
                .font(.headline)
                .padding()
                .padding(.trailing, 160)
                
                searchBar
                    .offset(CGSize(width: 0, height: 20))
                    .padding()
                Spacer()
            }
            Image("Hero Image")
                .resizable()
                .aspectRatio(1.0, contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(25)
                .offset(CGSize(width: 110, height: -10))
        }
//        .aspectRatio(1.25, contentMode: .fit)
    }
    
    @ViewBuilder
    private var searchBar: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .foregroundStyle(Color("Secondary 4"))
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .foregroundStyle(Color("Secondary 3"))
                .padding(.all, 5)
            HStack {
                Image(systemName: "magnifyingglass")
                    .fontWeight(.semibold)
                    .padding([.top, .bottom, .leading])
                TextField("Search", text: $searchText)
                    .padding()
                    .onChange(of: searchText, perform: onChange)
            }
        }
        .aspectRatio(8, contentMode: .fit)
    }
}

#Preview {
    ZStack {
        Rectangle()
            .foregroundStyle(.gray)
            .ignoresSafeArea()
        Hero(searchText: StateContainer().$searchText)
    }
}
fileprivate struct StateContainer {
    @State var searchText = ""
}
