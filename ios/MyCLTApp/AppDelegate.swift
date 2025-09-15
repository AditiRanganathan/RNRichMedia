import UIKit
import React
import React_RCTAppDelegate
import ReactAppDependencyProvider
import CleverTapSDK
import CleverTapReact

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  var window: UIWindow?
  
  var reactNativeDelegate: ReactNativeDelegate?
  var reactNativeFactory: RCTReactNativeFactory?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    CleverTap.autoIntegrate() // integrate CleverTap SDK using the autoIntegrate option
    registerForPush()
    CleverTapReactManager.sharedInstance()?.applicationDidLaunch(options: launchOptions)
    
    let delegate = ReactNativeDelegate()
    let factory = RCTReactNativeFactory(delegate: delegate)
    delegate.dependencyProvider = RCTAppDependencyProvider()
    
    reactNativeDelegate = delegate
    reactNativeFactory = factory
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    factory.startReactNative(
      withModuleName: "MyCLTApp",
      in: window,
      launchOptions: launchOptions
    )
    
    return true
    
  }
  
  func registerForPush() {
    // Register for Push notifications
    UNUserNotificationCenter.current().delegate = self
    // request Permissions
    UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert], completionHandler: {granted, error in
      if granted {
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    })
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification,
                                  withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.badge, .sound, .alert])
  }
  
  class ReactNativeDelegate: RCTDefaultReactNativeFactoryDelegate {
    override func sourceURL(for bridge: RCTBridge) -> URL? {
      self.bundleURL()
    }
    
    override func bundleURL() -> URL? {
#if DEBUG
      RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
#else
      Bundle.main.url(forResource: "main", withExtension: "jsbundle")
#endif
    }
  }
}
