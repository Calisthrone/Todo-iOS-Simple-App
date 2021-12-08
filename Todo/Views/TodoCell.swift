
import UIKit

class TodoCell: UITableViewCell {
    
    // oulets
    @IBOutlet var todoTitleLabel: UILabel!
    @IBOutlet var todoDateLabel: UILabel!
    @IBOutlet var todoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
