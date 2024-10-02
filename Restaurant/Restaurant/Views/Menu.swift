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
    
    @State var searchText = ""
    
    var body: some View {
        VStack {
            Text("Chicago")
            Text("This app lets you order deliveries from the Little Lemon restaurant.")
            TextField("Search menu", text: $searchText)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        DishRow(dish)
                    }
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }
    
    @ViewBuilder
    func DishRow(_ dish: Dish) -> some View {
        HStack {
            Text("\(dish.title!) $\(dish.price!)")
            
            Spacer()
            
            AsyncImage(url: URL(string: dish.image!)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        
        let url = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let urlObject = URL(string: url)!
        let urlRequest = URLRequest(url: urlObject)
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            let menuData = try? decoder.decode(MenuList.self, from: data)
            
            guard let menuData = menuData else { return }
            
            for item in menuData.menu {
                let newDish = Dish(context: viewContext)
                newDish.title = item.title
                newDish.image = item.image
                newDish.price = item.price
                
                newDish.dishDescription = item.dishDescription
                newDish.category = item.category
                newDish.id = Int64(item.id)
            }
            
            try? viewContext.save()
        }
        task.resume()
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
