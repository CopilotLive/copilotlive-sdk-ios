//
//  AppDelegate.swift
//  Example-Copilot-SPM
//
//  Created by Sagar Kumar on 16/01/25.
//

import UIKit
import CopilotSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initializeCopilotSDK()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    
    /// Initializes the Copilot SDK with user data, custom appearance settings, and a configuration object.
    ///
    /// This function demonstrates how to set up the Copilot SDK by:
    /// 1. Creating a `CopilotUser` object with user-specific details.
    /// 2. Customizing the UI appearance using a `CopilotAppearance` object.
    /// 3. Creating a `CopilotConfig` object with the necessary configuration.
    /// 4. Initializing the SDK with the configured `CopilotConfig`.
    ///
    /// - Note:
    ///   - Ensure the `token` parameter in the `CopilotConfig` points to the correct Copilot token.
    ///   - Replace placeholder values in `CopilotUser` with actual user data before initialization.
    ///
    /// - Example Usage:
    /// ```swift
    /// initializeCopilotSDK()
    /// ```
    func initializeCopilotSDK() {
        // Create a user object with placeholder data. Replace these values with real user data.
        let userData = CopilotUser(
            fullName: "", // The full name of the user
            phoneNumber: "", // The user's phone number
            profileImageUrl: "", // URL for the user's profile image
            emailAddress: "", // The user's email address
            userIdentifier: "" // A unique identifier for the user
        )
        
        // Define appearance settings for the Copilot UI
        let appearance = CopilotAppearance(
            title: "Copilot Assistant", // Title displayed in the navigation bar
            backgroundColor: "#FFFFFF", // Background for the copilot view
            navigationBarTintColor: "#000000", // Tint for the navigation bar
            navigationBarBackgroundColor: "#F2F2F2" // Background for the navigation bar
        )
        
        // Create a configuration object with the token, user data, and appearance settings
        let config = CopilotConfig(
            token: "YOUR_COPILOT_TOKEN", // Replace with your actual Copilot token
            user: userData, // Pass the user data
            appearance: appearance // Pass the appearance settings
        )
        
        // Initialize the Copilot SDK with the configuration
        Copilot.shared.initialize(with: config)
    }
}

