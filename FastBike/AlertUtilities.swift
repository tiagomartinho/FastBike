import UIKit

class AlertUtilities {
    static func showErrorAlert(viewController: UIViewController) {
        let alert = UIAlertController(title: "Attenzione",
                                      message: "Per usare l'applicazione devi permettere l'uso della tua posizione",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Attiva posizione", style: .default, handler: { _ in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [String:Any](), completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Annulla", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
