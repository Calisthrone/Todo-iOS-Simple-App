
import UIKit

class NewTodoVC: UIViewController {
    
    // boolean to decide wether (New Todo) or (Edited Todo)
    var isCreation = true
    
    // optionals -> becasue maybe is a (New Todo) or (Edited Todo)
    var editedTodo: Todo?
    var editedTodoIndex: Int?
    
    // outlets
    @IBOutlet var newTodoTitleLabel: UITextField!
    @IBOutlet var newTodoDetailsTextField: UITextView!
    @IBOutlet var editOrAddBtn: UIButton!
    @IBOutlet var todoImageView: UIImageView!
    @IBOutlet var addOrEditImageBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI modification in case of NewTodoVC is in edit mode
        if !isCreation {
            
            // change the main btn title from adding to editing
            editOrAddBtn.setTitle("Edit Todo", for: .normal)
            
            // change the image btn title from adding to editing an image
            addOrEditImageBtn.setTitle("Edit Image", for: .normal)
            
            navigationItem.title = "Edit Todo"
            
            // if comming from edit screen and there is an edited todo
            // update UI with the edited todo title, details and image
            if let todo = editedTodo {
                newTodoTitleLabel.text = todo.todoTile
                newTodoDetailsTextField.text = todo.todoDetails
                todoImageView.image = todo.todoImage
            }
            
        }
        
    } // MARK: END OF - viewDidLoad
    
    // when add image btn is clicked
    @IBAction func imageBtnClicked(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func addTodoBtnClicked(_ sender: Any) {
        
        // switch cases for adding new todo or editing a current todo
        switch isCreation {
            
        case true: // create a new todo
            
            let newTodo = Todo(todoTile: newTodoTitleLabel.text!, todoImage: todoImageView.image, todoDetails: newTodoDetailsTextField.text)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewTodoAdded"), object: nil, userInfo: ["NewTodoAdded" : newTodo])
            
            let alert = UIAlertController(title: "Todo Craeted", message: "Success, a new todo was created!", preferredStyle: UIAlertController.Style.actionSheet)
            
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
                self.tabBarController?.selectedIndex = 0
                self.newTodoTitleLabel.text = ""
                self.newTodoDetailsTextField.text = ""
                self.todoImageView.image = nil
            }
            
            alert.addAction(alertAction)
            
            self.present(alert, animated: true, completion: nil)
            
        case false: // edit current todo
            
            let todo = Todo(todoTile: newTodoTitleLabel.text!, todoImage: todoImageView.image, todoDetails: newTodoDetailsTextField.text)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "currentTodoEdited"), object: nil, userInfo: ["EdditedTodo" : todo, "editedIndex" : editedTodoIndex as Any])
            
            let alert = UIAlertController(title: "Todo Edited", message: "Success, your current to do is edited!", preferredStyle: .actionSheet)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
                self.navigationController?.popViewController(animated: true)
                
            }
            alert.addAction(alertAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
} // MARK: END OF - NewTodoVC

// MARK: - Extension: UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension NewTodoVC : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // manages the image selection for todos
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
        
        todoImageView.image = image
        
        editedTodo?.todoImage = image
    }
    
}
