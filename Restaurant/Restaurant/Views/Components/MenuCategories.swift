//
//  MenuCategories.swift
//  Restaurant
//
//  Created by MainUser on 3/10/2024.
//

import SwiftUI

struct MenuCategories: View {
    @Binding var foodCategory: FoodCategory?
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color("Secondary 3"))
            VStack {
                HStack {
                    Text("ORDER FOR DELIVERY")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .padding([.top, .leading])
                    Spacer()
                }
                HStack {
                    Spacer()
                    ForEach(FoodCategory.allCases, id: \.self) { category in
                        CategoryButton(category: category)
                            .padding(.bottom, 20)
                        Spacer()
                    }
                }
            }
        }
        .aspectRatio(7, contentMode: .fit)
    }
    
    @ViewBuilder
    private func CategoryButton(category: FoodCategory) -> some View {
        Group {
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .foregroundStyle(foodCategory == category ? Color("Primary 1") : Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .animation(.default, value: foodCategory)
                Text(category.rawValue)
                    .foregroundStyle(foodCategory == category ? Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)) : Color("Secondary 4"))
                    .animation(.default, value: foodCategory)
                    .fontWeight(.bold)
                    .padding(2.5)
                    .padding([.top, .bottom], 5)
            }
        }
        .onTapGesture {
            if foodCategory == category {
                foodCategory = nil
            } else {
                foodCategory = category
            }
        }
    }
}

enum FoodCategory: String, CaseIterable {
    case starters = "Starters"
    case mains = "Mains"
    case desserts = "Desserts"
    case Sides = "Sides"
}

extension FoodCategory {
    func getPredicate() -> NSPredicate {
        return NSPredicate(format: "category == %@", self.rawValue.lowercased())
    }
}

#Preview {
    ZStack {
        Rectangle()
            .foregroundStyle(.gray)
            .ignoresSafeArea()
        PreviewView()
    }
}
fileprivate struct PreviewView: View {
    @State var category: FoodCategory? = nil
    var body: some View {
        MenuCategories(foodCategory: $category)
    }
}
