import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        var error: NSError? = nil
        GGLContext.sharedInstance().configureWithError(&error)
        let gai = GAI.sharedInstance()
        gai?.trackUncaughtExceptions = true
        BuddyBuildSDK.setup()
        return true
    }
}
