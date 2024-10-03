import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext { container.viewContext }

    init() {
        container = NSPersistentContainer(name: "ExampleDatabase")
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: {_,_ in })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func clear() {
        // Delete all dishes from the store
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let _ = try? container.persistentStoreCoordinator.execute(deleteRequest, with: container.viewContext)
    }
    
    func getMenuData() {
        
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
                
                guard !exists(id: item.id) else { continue }
                
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
    
    func exists(id dishId: Int) -> Bool {
        let dishRequest = Dish.fetchRequest()
        
        // Assuming that dishes do not have duplicate id
        dishRequest.predicate = NSPredicate(format: "id == %@", "\(dishId)")
        
        do {
            let dishResults = try viewContext.fetch(dishRequest)
            return !dishResults.isEmpty
        } catch {
            return false
        }
    }
    
    // MARK: - For Preview Use
    #if DEBUG
    static let preview: PersistenceController = {
        let result = PersistenceController()
        let viewContext = result.container.viewContext
        
        // MARK: Add Test data here...
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    #endif
}
