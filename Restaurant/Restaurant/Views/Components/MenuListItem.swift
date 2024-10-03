//
//  MenuListItem.swift
//  Restaurant
//
//  Created by MainUser on 3/10/2024.
//

import SwiftUI

struct MenuListItem: View {
    let dish: Dish
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(dish.title!)
                        .foregroundStyle(Color("Primary 1"))
                        .fontWeight(.bold)
                        .padding(5)
                    Spacer()
                }
                HStack {
                    Text(dish.dishDescription!)
                        .foregroundStyle(Color("Secondary 4"))
                        .font(.custom("Karla", size: 16))
                        .lineLimit(2)
                        .padding(.leading, 5)
                    Spacer()
                }
                HStack {
                    Text("$\(Float(dish.price!)!, specifier: "%.2f")")
                        .fontWeight(.light)
                        .font(.custom("Karla", size: 18))
                        .foregroundStyle(Color("Primary 1"))
                        .padding(5)
                    Spacer()
                }
            }
            
            Spacer()
            
            AsyncImage(url: URL(string: dish.image!)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75, height: 75)
        }
    }
}

#Preview {
    List {
        MenuListItem(dish: DishContainer().dish)
    }
    .listStyle(.inset)
}
#if DEBUG
fileprivate struct DishContainer {
    var dish: Dish
    
    init() {
        self.dish = Dish(context: PersistenceController.shared.viewContext)
        self.dish.id = 1
        self.dish.title = "Greek Salad"
        self.dish.dishDescription = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
        self.dish.price = "10"
        self.dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
        self.dish.category = "starters"
    }
}
#endif
