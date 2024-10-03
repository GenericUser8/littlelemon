//
//  DishViewModel.swift
//  Restaurant
//
//  Created by MainUser on 3/10/2024.
//

import Foundation
import CoreData

class DishViewModel: ObservableObject {
    @Published var dishes = [Dish]()
    private var controller = PersistenceController.shared
    private var viewContext: NSManagedObjectContext { controller.container.viewContext }
    
    init() {
        
    }
    
    func getDishes(searchText: String = "") {
        controller.getMenuData()
        
        let dishRequest = Dish.fetchRequest()
        dishRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
        
        if !searchText.isEmpty {
            dishRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
        
        do {
            let fetchResults = try viewContext.fetch(dishRequest)
            self.dishes = fetchResults
        } catch {
            self.dishes = []
            print("Error occured with dish fetch: \(error)")
        }
    }
    
    #if DEBUG
    init(controller: PersistenceController) {
        self.controller = controller
    }
    #endif
}
