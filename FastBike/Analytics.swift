class Analytics {
    static func track(screen: String) {
        let tracker = GAI.sharedInstance().defaultTracker
        tracker?.set(kGAIScreenName, value: screen)
        let builder = GAIDictionaryBuilder.createScreenView().build() as [NSObject : AnyObject]
        tracker?.send(builder)
    }

    static func track(category: String, action: String, label: String) {
        let tracker = GAI.sharedInstance().defaultTracker
        let builder = GAIDictionaryBuilder.createEvent(withCategory: category,
                                                       action: action,
                                                       label: label,
                                                       value: 0).build() as [NSObject : AnyObject]
        tracker?.send(builder)
    }
}
