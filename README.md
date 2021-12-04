# Todo-iOS-Simple-App
**Todo**, a simple iOS app using CRUD and Core Data

**Todo** App is written in Swift and using CRUD operations with Core Data integration.

<img width="394" alt="Screen Shot 2021-12-05 at 1 16 59 AM" src="https://user-images.githubusercontent.com/76989642/144726589-2c986b41-07ab-4f77-aa79-2af60ba9f803.png">

### Main App Features:
- *Create new titled todos.*
- *Add an image and detail to a todo.*
- *Edit todos, including title, detail and image.*
- *Delete todos.*


### App Key Files:
- `Todo.wift` The main struct blueprint for each todo task.
- `MainVC` The main ViewController, hosting a tableView showing all todo tasks.
- `TodoDetailsVC` shows the selected todo task. User can update or delete todo from this ViewController.
- `NewTodoVC` allows for creating / editing todos.
- `CoreDataDelegates.swift` responsible for handling CRUD operations on Core Data.
