//
//  Menu.swift
//  Restaurant
//
//  Created by MainUser on 2/10/2024.
//

import SwiftUI
import Foundation

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var dishViewModel = DishViewModel()
    @State var searchText = ""
    @State var menuCategory: FoodCategory? = nil
    
    var body: some View {
        VStack {
            Hero(searchText: $searchText) {
                dishViewModel.getDishes(searchText: $0)
            }
            //            List {
            //                ForEach(dishViewModel.dishes, id: \.self) { dish in
            //                    DishRow(dish)
            //                }
            //            }
            MenuCategories(foodCategory: $menuCategory)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        MenuListItem(dish: dish)
                    }
                }
                .listStyle(.inset)
            }
            .task {
                PersistenceController.shared.getMenuData()
                dishViewModel.getDishes()
            }
        }
    }
    
    @ViewBuilder
    func DishRow(_ dish: Dish) -> some View {

    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        ]
    }
    
    func buildPredicate() -> NSCompoundPredicate {
        var predicates: [NSPredicate] = []
        
        if let menuCategory = menuCategory {
            predicates.append(menuCategory.getPredicate())
        }
        
        if !searchText.isEmpty {
            predicates.append(NSPredicate(format: "title CONTAINS[cd] %@", searchText))
        }
        
        return NSCompoundPredicate(type: .and, subpredicates: predicates)
    }
}

#Preview {
    Menu()
}
