//
//  ViewController.swift
//  Example-Copilot-Pods
//
//  Created by Sagar Kumar on 16/01/25.
//

import UIKit
import CopilotSDK

class ViewController: UIViewController {

    @IBAction func chatWithMe(_ sender: Any) {
        showConversations()
        
        /// Displays the Copilot conversation UI within the current view controller.
        ///
        /// This method is responsible for:
        /// 1. Setting an initial message to guide the user when the conversation screen opens.
        /// 2. Optionally pre-filling input values to customize the user interaction.
        /// 3. Presenting the Copilot conversation UI and assigning the current view controller as the delegate to handle conversation-related events.
        ///
        /// - Parameters:
        ///   - initialMessage: A message to display when the conversation screen opens, providing a starting point for the user.
        ///     - Example: `"Hello! How can I assist you today?"`
        ///     - If not needed, pass an empty string (`""`).
        ///   - initialValue: A pre-filled value for the input field. Use this to provide context or predefined input for the conversation.
        ///     - Example: `"Order #12345"`
        ///     - If not needed, pass an empty string (`""`).
        ///
        /// - Note:
        ///   - Ensure the Copilot SDK is initialized before calling this method.
        ///   - The delegate must conform to the `CopilotDelegate` protocol to handle conversation events.
        ///
        /// - Usage:
        /// ```
        /// Display the conversation UI.
        /// showConversations()
        /// ```
        ///
        /// - Example Output:
        /// When the method is called, the Copilot conversation UI will appear on the screen,
        /// displaying the `initialMessage` and optionally pre-filled input, enhancing user engagement.
        func showConversations() {
            // Define an initial message to guide the user when the conversation starts.
            let initialMessage = "" // Example: `"Hello! How can I assist you today?"`
            
            // Define an optional initial value for pre-filling the input field.
            let initialValue = "" // Example: Use "Order #12345" for order-related queries, or leave it empty.
            
            // Present the Copilot conversation UI.
            Copilot.shared.showConversations(
                on: self, // The current view controller where the UI will be presented.
                initialMessage: initialMessage, // Pass the initial message to be displayed.
                initialValue: initialValue, // Pass the initial value for input (optional).
                delegate: self // Assign the current view controller as the delegate for handling events.
            )
        }
    }
    
    @IBAction func callMeHere(_ sender: Any) {
        /// Call `makeCall` method to initiate the voice call.
        Copilot.shared.makeCall(on: self, delegate: self)
    }
}

extension ViewController: CopilotDelegate {
    
    /// Notifies when conversation are successfully loaded.
    func didLoadConversation() {
        print("Conversation successfully loaded.")
        // Add additional logic, such as updating the UI or notifying the user
    }
    
    /// Notifies when loading conversations fails.
    /// - Parameter error: A description of the error that occurred while loading conversation.
    func didFailToLoadConversation(withError error: String) {
        print("Failed to load conversation: \(error)")
        // Add error handling logic, such as displaying an error message
    }
    
    /// Notifies when a deep link is received.
    /// - Parameter url: The URL associated with the received deep link.
    func didReceiveDeepLink(url: String) {
        print("Deep link received: \(url)")
        // Handle the deep link, such as navigating to a specific screen
    }
}
