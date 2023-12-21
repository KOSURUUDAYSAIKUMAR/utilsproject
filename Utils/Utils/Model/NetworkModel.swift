//
//  ViewModel.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 20/12/23.
//

import UIKit
@objc protocol ViewModelDelegate: AnyObject {
    @objc func networkConnectionMsg(text: String, status: Bool)
}

class ViewModel: NSObject {
    weak var network: ViewModelDelegate?
    
    func isCheckNetworkHandler() {
        let reachability = try! Reachability()
        // closure mode
        // Enter when connection is available
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        // Enter if there is no connection
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }
        // Start notification
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func notifyViewWillAppear() {
        // Notify pattern
        let reachability = try! Reachability()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Could not start reachability notifier")
        }
    }
    
    func notifyViewDidAppear() {
        //stop notifications
        let reachability = try! Reachability()
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .none:
            print("not connected")
            network?.networkConnectionMsg(text: "Network not connected", status: false)
        case .unavailable:
            print("Network not reachable")
            network?.networkConnectionMsg(text: "Network not connected", status: false)
        case .wifi:
            print("Reachable via WiFi")
            network?.networkConnectionMsg(text: "Network connected wifi", status: true)
        case .cellular:
            print("Reachable via Cellular")
            network?.networkConnectionMsg(text: "Network connected Cellular", status: true)
        }
    }
}
