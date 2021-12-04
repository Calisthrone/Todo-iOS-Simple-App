
import UIKit

/*
 The main Todo struct:
 - todoTitle: the title of the todo (Mandatory)
 - todoImage: optional, so user can decide to choose an image or the app will assign a default image if nil
 - todoDetails: optional, so user can decide to set details or not for the todo
 */

struct Todo {
    
    var todoTile: String
    var todoImage: UIImage? = nil
    var todoDetails: String? = nil
}
