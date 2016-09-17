import UIKit
import AVFoundation

class ReportController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var problemDescription: UITextField!
    
    @IBOutlet weak var photo: UIImageView!

    let textFieldShouldReturn = TextFieldShouldReturn()

    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldShouldReturn.addTextField(textField: problemDescription)
    }

    @IBAction func cancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func send(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func takePhoto(_ sender: AnyObject) {
        let cameraMediaType = AVMediaTypeVideo
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: cameraMediaType)

        switch cameraAuthorizationStatus {
        case .authorized:
            self.openCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: cameraMediaType) { granted in
                if granted {
                    self.openCamera()
                }
            }
        default:
            AlertUtilities.showErrorAlert(viewController: self, message: "Per aggiungere una foto al report devi permettere l'uso della tua fotocamera", action: "Attiva fotocamera")
        }
    }

    func openCamera() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            photo.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

class TextFieldShouldReturn: NSObject, UITextFieldDelegate {

    func addTextField(textField:UITextField){
        textField.delegate=self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
