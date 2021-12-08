# Todo-iOS-Simple-App
**Todo**, a simple iOS app using CRUD and Core Data
And using MVC archtechture

**Todo** App is written in Swift and using CRUD operations with Core Data integration.

<img width="382" alt="1" src="https://user-images.githubusercontent.com/76989642/145259890-5d566796-e470-4b69-a917-1007ac087dea.png">   <img width="388" alt="2" src="https://user-images.githubusercontent.com/76989642/145259919-b5301acd-342a-4bea-b10f-12105772ef10.png">

<img width="385" alt="3" src="https://user-images.githubusercontent.com/76989642/145259960-3f9f718d-1dbe-45d4-938d-e74dc13e96e5.png">   <img width="391" alt="4" src="https://user-images.githubusercontent.com/76989642/145259991-c27680be-efb1-47b0-9d56-94548fdb8712.png">


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


### Things To Add/Improve:
- Add Date to indicatate the real time a todo task was created.
- Add a floating button for adding a new todo to remove the Tab Bar navigation (save some screen real estate)
- Fix default image not showing when editing a todo task without a user-selected image.
- Add a checkbox to the tableView to mark a todo task as completed and move it to the buttom of the list with different text style.
