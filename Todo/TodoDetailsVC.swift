
import UIKit

class TodoDetailsVC: UIViewController {
    
    // forced optionals becasue these will always be available from MainVC
    var todo: Todo!
    var index: Int!
    
    // outlets
    @IBOutlet var detailsImageView: UIImageView!
    @IBOutlet var detailsTileLabel: UILabel!
    @IBOutlet var detailsDetailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // displays the image of the todo
        if todo.todoImage != nil {
            detailsImageView.image = todo.todoImage
        } else {
            detailsImageView.image = UIImage.init(named: "default")
        }
        
        updateUI()
        
        // observing any changes to the todo if edited
        NotificationCenter.default.addObserver(self, selector: #selector(todoEdited), name: NSNotification.Name(rawValue: "currentTodoEdited"), object: nil)
        

        
    } // MARK: END OF - viewDidLoad
    
    // selecor method for edited todo notifiacation
    @objc func todoEdited(notification: Notification) {
        if let editedTodo = notification.userInfo?["EdditedTodo"] as? Todo {
            self.todo = editedTodo
            
            updateUI()
        }
    }
    
    /*
     when edit btn is clicked:
     - set the isCreation -> false indicating an edit actoion not a todo action
     - send the edited todo and its index to NewTodoVC
     - navigate to NewTodoVC
     */
    @IBAction func editTodoBtnClicked(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewTodoVC") as? NewTodoVC
        if let newTodoVC = vc {
            newTodoVC.isCreation = false
            newTodoVC.editedTodo = todo // this is the todo sent from the first screen
            newTodoVC.editedTodoIndex = self.index
            
            navigationController?.pushViewController(newTodoVC, animated: true)
        }
    }
    
    /*
     when delete btn is clicked:
     - display an alert to warn the user about the action
     - post a notification about the event
     - send the deleted index to MainVC to be deleted from the todos array and Core Data
     - navigate to MainVC after confirming the delete action
     */
    @IBAction func deleteBtnClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete Todo", message: "Do you really want to delete this todo?", preferredStyle: .actionSheet)
        
        // [self] -> capture self when needed: so we do not have to use self in closure
        let confirmAction = UIAlertAction(title: "Yes, delete", style: .destructive) { [self] _ in
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TodoDeleted"), object: nil, userInfo: ["deletedIndex" : index as Any])
            
            navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // update UI outlets when adding or editing a todo
    fileprivate func updateUI() {
        detailsTileLabel.text = todo.todoTile
        detailsDetailTextView.text = todo.todoDetails
        detailsImageView.image = todo.todoImage
    }

} // MARK: END OF - TodoDetailsVC
