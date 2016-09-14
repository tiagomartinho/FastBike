import UIKit

class ReportController: UITableViewController {

    @IBOutlet weak var problemDescription: UITextField!
    
    @IBOutlet weak var photo: UIImageView!

    @IBAction func cancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func send(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func takePhoto(_ sender: AnyObject) {
    }
}
