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
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
}

#Preview {
    Menu()
}
