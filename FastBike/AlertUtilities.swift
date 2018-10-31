import UIKit

class AlertUtilities {
    static func showErrorAlert(viewController: UIViewController, message: String, action: String) {
        let alert = UIAlertController(title: "Attenzione",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(url)
            }
        }))
        alert.addAction(UIAlertAction(title: "Annulla", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
