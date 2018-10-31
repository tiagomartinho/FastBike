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
        Analytics.track(category: "Report", action: "Cancel", label: "problemDescription: \(problemDescription.text ?? ""), foto: \(photo.image == nil ? "no" : "si")")
        dismiss(animated: true, completion: nil)
    }

    @IBAction func send(_ sender: AnyObject) {
        Analytics.track(category: "Report", action: "Send", label: "problemDescription: \(problemDescription.text ?? ""), foto: \(photo.image == nil ? "no" : "si")")
        dismiss(animated: true, completion: nil)
    }

    @IBAction func takePhoto(_ sender: AnyObject) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)

        switch cameraAuthorizationStatus {
        case .authorized:
            self.openCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
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

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
