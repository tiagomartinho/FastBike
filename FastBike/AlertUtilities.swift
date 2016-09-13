import UIKit

class AlertUtilities {
    static func showErrorAlert(viewController: UIViewController) {
        let alert = UIAlertController(title: "Mi spiace 🤗",
                                      message: "Stai senza bici 🏃🏻",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok...", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
