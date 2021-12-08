
import UIKit
import CoreData

class MainVC: UIViewController {
    
    // the main array containing created or edited todos
    var todos = [Todo]()
    
    @IBOutlet var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // reload saved todos from Core Data
        todos = CoreDataDelegates.getTodoFromCoreData()
        
        // observing newly created todos from NewTodoVC
        NotificationCenter.default.addObserver(self, selector: #selector(newTodoAdded), name: NSNotification.Name(rawValue: "NewTodoAdded"), object: nil)
        
        // observing edited todos from NewTodoVC
        NotificationCenter.default.addObserver(self, selector: #selector(currentTodoEdited), name: NSNotification.Name(rawValue: "currentTodoEdited"), object: nil)
        
        // observing deleted todos from TodoDetailsVC
        NotificationCenter.default.addObserver(self, selector: #selector(todoDeleted), name: NSNotification.Name(rawValue: "TodoDeleted"), object: nil)
        
        // assign the datasource and delegates to MainVC
        todoTableView.dataSource = self
        todoTableView.delegate = self
        
    } // MARK: END OF - viewDidLoad
    
    // selecor method for newly added todos notifiacation
    @objc func newTodoAdded(newNotification: Notification) {
        
        let receivedTodo = newNotification.userInfo?["NewTodoAdded"] as? Todo
        
        if let newTodo = receivedTodo {
            let newTodo = Todo(todoTile: newTodo.todoTile, todoImage: newTodo.todoImage, todoDetails: newTodo.todoDetails)
            todos.append(newTodo)
            todoTableView.reloadData()
            
            // save new todo to Core Data
            CoreDataDelegates.saveTodoToCoreData(todo: newTodo)
        }
    }
    
    // selector method for edited todos notification
    @objc func currentTodoEdited(notification: Notification) {
        if let editedTodo = notification.userInfo?["EdditedTodo"] as? Todo {
            if let editedIndex = notification.userInfo?["editedIndex"] as? Int {
                todos[editedIndex] = editedTodo
                todoTableView.reloadData()
                
                // save edited todo to Core Date
                CoreDataDelegates.updateTodoToCoreData(todo: editedTodo, index: editedIndex)
            }
        }
    }
    
    // selector method for deleted todo notification
    @objc func todoDeleted(notification: Notification) {
        
        if let deletedIndex = notification.userInfo?["deletedIndex"] as? Int {
            todos.remove(at: deletedIndex)
            todoTableView.reloadData()
            
            // delete todo from Core Data
            CoreDataDelegates.deleteFromCoreData(index: deletedIndex)
        }
        
    }
    
    
} // MARK: END OF - MainVC


// MARK: - MainVC extension: UITableViewDataSource

extension MainVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodoCell
        
        cell.todoTitleLabel.text = todos[indexPath.row].todoTile
        
        // set default image if the user did not select an image for the created ot edited todo
        if todos[indexPath.row].todoImage != nil {
            cell.todoImageView.image = todos[indexPath.row].todoImage
        } else {
            cell.todoImageView.image = UIImage(named: "default")
        }
        
        // the image will be in a circular shape
        cell.todoImageView.layer.cornerRadius = cell.todoImageView.frame.width / 2
        
        return cell
    }
    
} // MARK: END OF - MainVC extension : UITableViewDataSource


// MARK: - MainVC extension: UITableViewDelegate

extension MainVC: UITableViewDelegate {
    
    // this method will pass the current selected todo and index to DetailsVC when a todo is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // remove the visual selection tint when clicked
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailsVC") as? TodoDetailsVC
        
        if let detailsVC = vc {
            let currentTodo = todos[indexPath.row]
            detailsVC.todo = currentTodo
            
            // send the indexPath.row -> inex (TodoDetailsVC)
            detailsVC.index = indexPath.row
            
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
} // MARK: END OF - MainVC extension: UITableViewDelegate
