//
//  ViewController.swift
//  Example-Copilot-SPM
//
//  Created by Sagar Kumar on 16/01/25.
//

import UIKit
import CopilotSDK

class ViewController: UIViewController {
    
    @IBAction func chatWithMe(_ sender: Any) {
        showConversations()
    }
    
    @IBAction func callMeHere(_ sender: Any) {
        /// Call `makeCall` method to initiate the voice call.
        Copilot.shared.makeCall(on: self, delegate: self)
    }
    
    @IBAction func login(_ sender: Any) {
        login()
        showConversations()
    }
    
    @IBAction func logout(_ sender: Any) {
        Copilot.shared.unsetUser()
    }
    
    func showConversations() {
        // Define an initial message to guide the user when the conversation starts.
        let initialMessage = "" // Example: `"Hello! How can I assist you today?"`
        
        // Define an optional initial value for pre-filling the input field.
        let initialValue = "" // Example: Use "Order #12345" for order-related queries, or leave it empty.
        
        // Present the CoPilot conversation UI.
        Copilot.shared.open(
            on: self, // The current view controller where the UI will be presented.
            initialMessage: initialMessage, // Pass the initial message to be displayed.
            initialValue: initialValue, // Pass the initial value for input (optional).
            delegate: self // Assign the current view controller as the delegate for handling events.
        )
    }
    
    func login() {
        let userData = CopilotUser(
            fullName: "", // The full name of the user
            phoneNumber: "", // The user's phone number
            profileImageUrl: "", // URL for the user's profile image
            emailAddress: "", // The user's email address
            userIdentifier: "", // A unique identifier for the user
            additionalFields: [:]
        )
        Copilot.shared.setUser(userData)
    }
}

extension ViewController: CopilotDelegate {
    
    /// Called to notify about an error event.
    /// - Parameter error: A generic error object or information describing the error.
    func didReceiveError(_ error: Any) {
        // Handle the error here
        print("Error received: \(error)")
    }
    
    /// Called when a deep link is received.
    /// - Parameter url: The URL associated with the received deep link.
    func didReceiveDeepLink(_ url: String) {
        print("Deep link received: \(url)")
    }
    
    /// Called to report telemetry events.
    /// - Parameter event: The telemetry event.
    func didReceiveTelemetry(_ event: TelemetryEvent) {
        switch event.type {
        case .widgetLoad:
            print("Widget loaded with params: \(event.parameters)")
            
        case .widgetOpen:
            print("Widget opened with params: \(event.parameters)")
            
        case .widgetClose:
            print("Widget closed with params: \(event.parameters)")
            
        case .userMessage:
            print("User message with params: \(event.parameters)")
            
        case .userMessageStop:
            print("User message stopped with params: \(event.parameters)")
            
        case .assistantMessage:
            print("Assistant message with params: \(event.parameters)")
            
        case .assistantSuggestions:
            print("Assistant suggestions with params: \(event.parameters)")
            
        case .assistantComponentItemsView:
            print("Assistant component items view with params: \(event.parameters)")

        case .ctaClick:
            print("CTA clicked with params: \(event.parameters)")
            
        case .callConnect:
            print("Call connected with params: \(event.parameters)")
            
        case .callDisconnect:
            print("Call disconnected with params: \(event.parameters)")
            
        case .other(let type):
            print("Other event (\(type)) with params: \(event.parameters)")
        @unknown default:
            break
        }
    }
}
