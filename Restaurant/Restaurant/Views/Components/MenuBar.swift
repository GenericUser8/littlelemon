//
//  MenuBar.swift
//  Restaurant
//
//  Created by MainUser on 3/10/2024.
//

import SwiftUI

struct MenuBar: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.white)
                .aspectRatio(6, contentMode: .fit)
            HStack {
                Spacer()
                Image("little-lemon-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                Spacer()
            }
            HStack {
                Spacer()
                Image("profile-image-placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .padding(.trailing, 25)
            }
        }
    }
}

#Preview {
    ZStack {
        Rectangle()
            .foregroundStyle(.gray)
            .ignoresSafeArea()
        MenuBar()
    }
}
