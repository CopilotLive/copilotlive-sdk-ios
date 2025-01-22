
# Copilot SDK for iOS

## Overview

The Copilot SDK is a robust framework designed for seamless integration into iOS applications, offering a streamlined experience for developers. It supports both Swift Package Manager (SPM) and CocoaPods, ensuring flexibility and ease of integration. The minimum deployment target is iOS 13.

## Features

- Easy integration with SPM and CocoaPods.
- Compatible with iOS 13 and later.
- Modular and extensible design.
- Lightweight and optimized for performance.
- Provides conversation interfaces and deep linking capabilities.
- User authentication and UI appearance customization support.

## Requirements

- **iOS Version:** iOS 13+
- **Languages:** Swift, Objective-C
- **Package Managers:** SPM, CocoaPods

## Installation

### Swift Package Manager

To integrate the Copilot SDK using Swift Package Manager:

1. Open your project in Xcode
   - Make sure you're using Xcode 11 or later as SPM support was introduced in Xcode 11.
2. Go to your Project Settings
   - Select your project in the Xcode navigation.
   - In the project editor, select the target you want to add the package to.
4. Add Package Dependency
   - In the project settings, click on the "Package Dependencies" tab.
   - Click the + button to add a new package.
5. Enter the Package URL
   
   ```ruby
   https://github.com/CopilotLive/sdk-ios
   ```
   
7. Choose the desired version or branch and click **Add Package**.

### CocoaPods

To integrate the Copilot SDK using CocoaPods:

1. Add the following line to your `Podfile`:
   
   ```ruby
   pod 'CopilotSDK', :git => 'https://github.com/CopilotLive/sdk-ios'
   ```
   
3. Run the command:
   
   ```bash
   pod install
   ```
   
5. Open the `.xcworkspace` file to start using the SDK.


## Permissions

#### Microphone Permission

Steps to Add Microphone Permission

Update `Info.plist`
Add the `NSMicrophoneUsageDescription` key in your app's Info.plist file. This key defines the message displayed to users when the app requests microphone access.

Example entry in `Info.plist`:

```ruby
<key>NSMicrophoneUsageDescription</key>
<string>We need access to your microphone for voice interactions.</string>
```

## Usage

### Initialization

To initialize the Copilot SDK, add the following code in your `AppDelegate` or at the start of your app lifecycle:

```swift
import CopilotSDK

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     // Override point for customization after application launch.
     initializeCopilotSDK()
     return true
}

func initializeCopilotSDK() {
     // Create a user object with placeholder data. Replace these values with real user data.
     let user = CopilotUser(
         fullName: "", // The full name of the user
         phoneNumber: "", // The user's phone number
         profileImageUrl: "", // URL for the user's profile image
         emailAddress: "", // The user's email address
         userIdentifier: "" // A unique identifier for the user
      )
        
      // Define appearance settings for the Copilot UI
      let appearance = CopilotAppearance(
          navigationBarBackgroundColor: "#E9FBFB", // LBackground for the navigation bar
          backgroundColor: "#E9FBFB", // Background for the copilot view
          navigationBarTitle: "Copilot Assistant" // Title displayed in the navigation bar
      )
        
      // Create a configuration object with the URL, user data, and appearance settings
      let config = CopilotConfig(
          url: "https://test.ai.copilot.live/", // Copilot URL
          user: user, // Pass the user data
          appearance: appearance // Pass the appearance settings
      )
        
      // Initialize the Copilot SDK with the configuration
      Copilot.shared.initialize(with: config)
}

```

### User Management

To personalize the chat experience, you need to set the authenticated user by providing their details. This allows Copilot to respond more effectively based on user-specific information.

```swift
let user = CopilotUser(
    fullName: "", // The full name of the user
    phoneNumber: "", // The user's phone number
    profileImageUrl: "", // URL for the user's profile image
    emailAddress: "", // The user's email address
    userIdentifier: "" // A unique identifier for the user
)
```

#### You can set the user using any of the following options:

##### 1. Set user during initialization 

```swift   
Copilot.shared.initialize(
    with: CopilotConfig(
        user: user
    )
)
```

##### 2. Set user after initialization 

```swift
Copilot.shared.setUser(user)
```

##### 3. Set user when the user logs in 

```swift
Copilot.shared.notifyLoginSuccess(user)
```

#### Logging Out

To log out the current user:

```swift
Copilot.shared.logout()
```

### Customizing Appearance

To set a custom appearance:

```swift
let appearance = CopilotAppearance(
                   navigationBarBackgroundColor: "#E9FBFB", // Background for the navigation bar
                   backgroundColor: "#E9FBFB", // Background for the main UI
                   navigationBarTitle: "Copilot Assistant" // Title displayed in the navigation bar
        )
Copilot.shared.setAppearance(appearance)
```

### Conversations

#### Displaying Conversations

To show the conversation interface:

```swift
import UIKit

class MyViewController: UIViewController {

    func showConversation() {
        Copilot.shared.showConversations(on: self, initialMessage: "Hello!", delegate: self)
    }
}
```

#### Delegate Implementation

Conform to `CopilotDelegate` to handle conversation events:

```swift
extension MyViewController: CopilotDelegate {

    func didLoadConversation() {
        print("Conversations successfully loaded.")
        // Add additional logic, such as updating the UI or notifying the user
    }

    func didFailToLoadConversation(withError error: String) {
        print("Failed to load conversations: \(error)")
        // Displaying an error message
    }

    func didReceiveDeepLink(url: String) {
        print("Deep link received: \(url)")
        // Handle the deep link, such as navigating to a specific screen
    }
}
```

## API Reference

### `initialize(with config: CopilotConfig)`

Initializes the SDK with the provided configuration.

- **Parameters:**
  - `config` (CopilotConfig): The configuration containing the URL, user details, and UI appearance.

### `setUser(_ user: CopilotUser)`

Sets the authenticated user for the SDK.

- **Parameters:**
  - `user` (CopilotUser): The user object to be set.

### `logout()`

Logs out the currently authenticated user.

### `notifyLoginSuccess(_ user: CopilotUser)`

Notifies the SDK of a successful user login.

- **Parameters:**
  - `user` (CopilotUser): The user object representing the successfully logged-in user.

### `setAppearance(_ appearance: CopilotAppearance)`

Sets the UI appearance for the SDK.

- **Parameters:**
  - `appearance` (CopilotAppearance): The appearance object to be set.

### `showConversations(on controller: UIViewController?, initialMessage: String?, initialValue: String?, delegate: CopilotDelegate?)`

Displays the conversation interface on the specified view controller.

- **Parameters:**
  - `controller` (UIViewController?): The view controller where the conversation will be displayed.
  - `initialMessage` (String?): The initial message to display in the conversation (optional).
  -  `initialValue` (String?): The initial value to provide context or predefined input for the conversation. (optional).
  - `delegate` (CopilotDelegate?): The delegate to handle interaction events (optional).


## Troubleshooting

### Common Issues

- **Error: "Unsupported iOS version"**
  - Ensure the deployment target is set to iOS 13 or later.
- **Error: "Module not found"**
  - Verify that the SDK is correctly installed via SPM or CocoaPods.
- **Error: "Failed to load CoPilot URL"**
  - Ensure the configuration URL is valid and accessible.


