import WatchKit

class AlertUtilities {
    static func showErrorAlert(viewController: WKInterfaceController) {
        let action = WKAlertAction(title: "Ok...", style: .default) { }
        viewController.presentAlert(withTitle: "Mi spiace 🤗", message: "Stai senza bici 🏃🏻", preferredStyle: .actionSheet, actions: [action])
    }
}
