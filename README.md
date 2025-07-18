
# Copilot SDK for iOS

## Overview

The Copilot SDK is a robust framework designed for seamless integration into iOS applications, offering a streamlined experience for developers. It supports both Swift Package Manager (SPM) and CocoaPods, ensuring flexibility and ease of integration. The minimum deployment target is iOS 15.

## SDK Requirements

1. **Login** to the [Copilot Platform](https://platform.copilot.live/)

2. **Open your Copilot** and Navigate to the **Deploy** section to retrieve the integration token. Refer to the [Mobile SDK Documentation](https://platform.copilot.live/docs/deployments/mobile/) for more details.

## Features

- Easy integration with SPM and CocoaPods.
- Compatible with iOS 15 and later.
- Modular and extensible design.
- Lightweight and optimized for performance.
- Provides **conversation interfaces**, **deep linking capabilities**, and **voice call assistance**.
- Supports **user authentication** and **UI appearance customization**.

## Requirements

- **iOS Version:** iOS 15+
- **Languages:** Swift, Objective-C
- **Package Managers:** SPM, CocoaPods

## Installation

### Swift Package Manager

To integrate the Copilot SDK using **Swift Package Manager**:

1. Open your project in Xcode (version 11+ is required).
2. Go to Project Settings.
3. Select your project and navigate to the Package Dependencies tab.
4. Click the **+ button** to add a new package.
5. Enter the package URL:
   
   ```ruby
   https://github.com/CopilotLive/copilotlive-sdk-ios
   ```
   
6. Choose the desired version or branch and click **Add Package**.

### CocoaPods

To integrate the Copilot SDK using **CocoaPods**:

1. Add the following line to your `Podfile`:
   
   ```ruby
   pod 'CopilotSDK'
   ```
   
3. Run the command:
   
   ```bash
   pod install
   ```
   
3. Open the `.xcworkspace` file to start using the **SDK**.


## Permissions

The Copilot SDK requires certain permissions to enable core functionalities like voice interactions and seamless communication. Ensure the necessary permissions are granted in the app’s `Info.plist` file.

#### Microphone Permission

To enable microphone access, update the `Info.plist` file by adding the following key:

```ruby
<key>NSMicrophoneUsageDescription</key>
<string>We need access to your microphone for voice interactions.</string>
```

This permission is required to enable voice-based interactions, including making calls and using the assistant hands-free.

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
         userIdentifier: "", // A unique identifier for the user
         additionalFields: [:] // Additional user information
      )
        
      // Define appearance settings for the Copilot UI
      let appearance = CopilotAppearance(
          title: "Copilot Assistant", // Title displayed in the navigation bar
          backgroundColor: "#FFFFFF", // Background for the copilot view
          navigationBarTintColor: "#000000", // Tint for the navigation bar
          navigationBarBackgroundColor: "#FFFFFF" // Background for the navigation bar
      )
        
      // Create a configuration object with the token, user data, and appearance settings
      let config = CopilotConfig(
          token: "YOUR_COPILOT_TOKEN", // Replace with your actual Copilot token
          user: user, // Pass the user data
          appearance: appearance // Pass the appearance settings
      )
        
      // Initialize the Copilot SDK with the configuration
      Copilot.shared.initialize(with: config)
}

```

### User Management

```swift
let user = CopilotUser(
    fullName: "", // The full name of the user
    phoneNumber: "", // The user's phone number
    profileImageUrl: "", // URL for the user's profile image
    emailAddress: "", // The user's email address
    userIdentifier: "", // A unique identifier for the user
    additionalFields: [:] // Additional user information
)
```

#### Setting the User in Copilot SDK
The Copilot SDK provides multiple ways to set the user for tracking and personalization purposes. You can choose the method that best fits your app's workflow:

##### 1. Set the User During Initialization
You can set the user directly when initializing the Copilot SDK. This is ideal when the user information is readily available at the time of app launch or SDK setup.

```swift   
Copilot.shared.initialize(
    with: CopilotConfig(
        user: user
    )
)
```

##### 2. Set the User After Initialization
If the user information becomes available later in the app lifecycle, you can set the user after the SDK has already been initialized.

```swift
Copilot.shared.setUser(user)
```
This method is useful when user details are fetched asynchronously, such as after a remote API call.

##### 3. Set the User on Login Success
When a user successfully logs into your app, you can notify the SDK to set the user. This ensures that the user's session is correctly tracked from the moment they log in.

```swift
Copilot.shared.notifyLoginSuccess(user)
```
This approach is particularly helpful in apps where user login is optional or delayed until a specific interaction.

#### Logging Out

To log out the current user:

```swift
Copilot.shared.unsetUser()
```

### Customizing Appearance

To set a custom appearance:

```swift
let appearance = CopilotAppearance(
                      title: "Copilot Assistant", // Title displayed in the navigation bar
                      backgroundColor: "#FFFFFF", // Background for the copilot view
                      navigationBarTintColor: "#000000", // Tint for the navigation bar
                      navigationBarBackgroundColor: "#FFFFFF" // Background for the navigation bar
                 )
Copilot.shared.setAppearance(appearance)
```

### Conversations

#### Displaying Conversations

This feature enables users to interact with the Copilot assistant through a text-based conversation interface. Users can send and receive messages within the app, making it easy to communicate with the assistant for support, guided workflows, or general assistance. The conversation history is maintained, allowing users to resume past interactions seamlessly. This ensures a smooth and real-time messaging experience without switching between different platforms.

```swift
import UIKit

class MyViewController: UIViewController {

    func showConversation() {
        Copilot.shared.open(on: self, initialMessage: "Hello!", delegate: self)
    }
}
```

#### Make a Call

This feature allows users to communicate with the Copilot assistant using voice instead of text. It is useful for hands-free interactions, accessibility needs, or situations where speaking is more convenient than typing. Users can initiate a real-time voice conversation within the app, making it easy to get assistance without manually typing queries. The call feature provides a seamless experience by enabling direct access to voice-based support without additional steps.

To enable this feature, ensure that microphone access is granted in `Info.plist`.

```swift
import UIKit

class MyViewController: UIViewController {

    func makeCall() {
        Copilot.shared.makeCall(on: self, delegate: self)
    }
}
```

#### Delegate Implementation

Conform to `CopilotDelegate` to handle conversation events:

```swift
extension MyViewController: CopilotDelegate {

    /// Called to notify about an error event from the Copilot.
    /// - Parameter error: A generic error object or descriptive information.
    func didReceiveError(_ error: Any) {
        print("Error received: \(error)")
        // Handle or log the error as appropriate
    }

    /// Called when a deep link is received from the Copilot.
    /// - Parameter url: The URL associated with the deep link.
    func didReceiveDeepLink(_ url: String) {
        print("Deep link received: \(url)")
        // Handle the deep link, such as navigating to a specific screen
    }

    /// Called when a telemetry event is triggered by the Copilot.
    /// - Parameter event: A telemetry event containing a type and optional parameters.
        func didReceiveTelemetry(_ event: TelemetryEvent) {
        switch event.type {
        case .widgetLoad:
            print("Widget loaded")
            
        case .widgetOpen:
            print("Widget opened")
            
        case .widgetClose:
            print("Widget closed")
            
        case .userMessage:
            print("User sent a message")
            
        case .userMessageStop:
            print("User clicked on stop button, which interurpts assistant message response.")
            
        case .assistantMessage:
            print("Assistant sent a message")
            
        case .assistantSuggestions:
            print("Suggestions shown")
            
        case .assistantComponentItemsView:
            print("Assistant component items view")
            
        case .ctaClick:
            print("User clicked a CTA")
            
        case .callConnect:
            print("Triggered when a user initiates or joins a voice call via Copilot.")
            
        case .callDisconnect:
            print("Triggered when a user ends or drops from the call.")
            
        case .other(let type):
            print("Other event (\(type)) with params: \(event.parameters)")
        }
    }
}
```

## API Reference

### `initialize`

Initializes the SDK with the provided configuration.

- **Parameters:**
  - `config` (CopilotConfig): The configuration containing the token, user details, and UI appearance.

### `setUser`

Sets the authenticated user for the SDK.

- **Parameters:**
  - `user` (CopilotUser): The user object to be set.

### `unsetUser`

Logs out the currently authenticated user.

### `notifyLoginSuccess`

Notifies the SDK of a successful user login.

- **Parameters:**
  - `user` (CopilotUser): The user object representing the successfully logged-in user.

### `setAppearance`

Sets the UI appearance for the SDK.

- **Parameters:**
  - `appearance` (CopilotAppearance): The appearance object to be set.
  
### `setContext`

Sets the dynamic context in which Copilot operates (such as user session details, screen metadata, cart contents, etc.).

- **Parameters:**
  - `options` ([String: Any]): A dictionary containing key-value pairs for the context to be set.
  
### `unsetContext`

Clears any previously set context from the Copilot SDK.

### `open`

Displays the conversation interface on the specified view controller.

- **Parameters:**
  - `controller` (UIViewController): The view controller where the conversation will be displayed.
  - `initialMessage` (String?): The initial message to display in the conversation (optional).
  -  `initialValue` (String?): The initial value to provide context or predefined input for the conversation. (optional).
  - `delegate` (CopilotDelegate?): The delegate to handle interaction events (optional).

### `makeCall`

Initiates a voice call on the specified view controller.

- **Parameters:**
  - `controller` (UIViewController): The view controller on which the voice call will be initiated.
  - `delegate` (CopilotDelegate?): The delegate to handle interaction events (optional).

### `close`

Closes the Copilot interface if it is currently open.

## Troubleshooting

### Common Issues

- **Error: "Unsupported iOS version"**
  - Ensure the deployment target is set to iOS 15 or later.
- **Error: "Module not found"**
  - Verify that the SDK is correctly installed via SPM or CocoaPods.
- **Error: "Failed to load Copilot"**
  - Ensure the configuration token is valid and accessible.
- **Error: "No internet connection"**
  - Check if the device has an active internet connection before initializing Copilot.

