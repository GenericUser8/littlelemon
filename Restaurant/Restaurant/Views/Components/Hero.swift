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
    var showSearch = true
    
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
                        .padding([.leading, .top, .trailing])
                    Spacer()
                }
                HStack {
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .foregroundStyle(Color("Secondary 3"))
                    .frame(height: 160)
                    .font(.headline)
                    .padding(.leading)
                    .multilineTextAlignment(.leading)
                    Spacer(minLength: 160)
                }
                
                if showSearch {
                    searchBar
                        .padding([.leading, .trailing])
                        .offset(x: 0, y: -10)
                    Spacer()
                }
            }
            Image("Hero Image")
                .resizable()
                .aspectRatio(1.0, contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(25)
                .offset(CGSize(width: 110, height: -10))
            Text("Chicago")
                .foregroundStyle(Color("Secondary 3"))
                .font(.custom("Times New Roman", size: 28))
                .fontWeight(.bold)
                .offset(CGSize(width: -135, height: (showSearch ? -80 : -50)))
        }
        .aspectRatio(2, contentMode: .fit)
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
