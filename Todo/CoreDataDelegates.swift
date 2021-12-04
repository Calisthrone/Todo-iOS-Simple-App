
import Foundation
import UIKit
import CoreData

/*
 This class contains the functions used by Core Data to save, edit and delete todos to Core Data
 As well as getting (loading) the previously saved todos from Core Data
 
 Functions are marked as static to be able to call them without instasiating an object from this class
 
 These functions are maily used in MainVC
 */

class CoreDataDelegates {
    
    // MARK: - Core Data Methods
    
    // saves the newly created todo to Core Data
    static func saveTodoToCoreData(todo: Todo) {
        
        // setup the container in AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // create an entity and new user records.
        let todoEntity = NSEntityDescription.entity(forEntityName: "Todos", in: managedContext)!
        
        // create the NSManagedObject
        let todoObject = NSManagedObject(entity: todoEntity, insertInto: managedContext)
        // add keys for each attribute
        todoObject.setValue(todo.todoTile, forKey: "title")
        todoObject.setValue(todo.todoDetails, forKey: "detail")
        
        // because the image may be nil at the first place
        if let image = todo.todoImage {
            let imageData = image.jpegData(compressionQuality: 1)
            todoObject.setValue(imageData, forKey: "image")
        }
        
        // save the core data
        do { try managedContext.save()
        } catch {
            print("Error")
        }
    } // saveTodoToCoreData
    
    // reload the saved todos from Core Data and save them into the main todos array to be displayed in UI
    static func getTodoFromCoreData() -> [Todo] {
        
        var todos = [Todo]()
        
        // setup the container in AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        
        // create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for managedTodo in result {
                
                let title = managedTodo.value(forKey: "title") as? String ?? ""
                let detail = managedTodo.value(forKey: "detail") as? String ?? ""
                
                // optional: if the image was not save by the user (nil) in the first place
                var image: UIImage? = nil
                if let imageDataFromContext = managedTodo.value(forKey: "image") as? Data {
                    image = UIImage(data: imageDataFromContext)
                }
                
                let todo = Todo(todoTile: title,todoImage: image, todoDetails: detail)
                
                todos.append(todo)
            }
            
        } catch {
            
        }
        
        return todos
    } // getTodoFromCoreData
    
    // update edited todos in Core data
    static func updateTodoToCoreData(todo: Todo, index: Int) {
        
        // setup the container in AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            result[index].setValue(todo.todoTile, forKey: "title")
            result[index].setValue(todo.todoDetails, forKey: "detail")
            
            // because the image may be nil at the first place
            if let image = todo.todoImage {
                let imageData = image.jpegData(compressionQuality: 1)
                result[index].setValue(imageData, forKey: "image")
            }
            
        } catch {
            print("set value error")
        }
        
        do {
            try managedContext.save()
        } catch {
            print("save context error")
        }
    } // updateTodoToCoreData
    
    // delete todo from Caore Data
    static func deleteFromCoreData(index: Int) {
        
        // setup the container in AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
        
        do { let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            let todoToBeDeleted = result[index]
            
            managedContext.delete(todoToBeDeleted)
            
        } catch {
            print("set value error")
        }
        
        do { try managedContext.save()
        } catch {
            print("save context error")
        }
    } // updateTodoToCoreData
    
} // MARK: END OF - CoreDataDelegates
