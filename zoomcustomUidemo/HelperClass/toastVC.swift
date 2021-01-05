//
//  toastVC.swift
//  zoomcustomUidemo
//
//  Created by Mahavir on 24/12/20.
//

import Foundation
import Network
import UIKit

public class toastVC:NSObject {
    static let sharedInstance = toastVC()
    var Message:String! = "Check Internet Connection!"
    var didStartMonitoringHandler: (() -> Void)?
    var didStopMonitoringHandler: (() -> Void)?
    var netStatusChangeHandler: (() -> Void)?
    var monitor: NWPathMonitor?
    var isMonitoring = false
    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    var interfaceType: NWInterface.InterfaceType? {
        guard let monitor = monitor else { return nil }
     
        return monitor.currentPath.availableInterfaces.filter {
            monitor.currentPath.usesInterfaceType($0.type) }.first?.type
    }
    var availableInterfacesTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.map { $0.type }
    }
    var isExpensive: Bool {
        return monitor?.currentPath.isExpensive ?? false
    }
    private override init() {
     
    }
    func startMonitoring() {
        guard !isMonitoring else { return }

        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetStatus_Monitor")
        monitor?.start(queue: queue)

        monitor?.pathUpdateHandler = { _ in
            self.netStatusChangeHandler?()
        }

        isMonitoring = true
        didStartMonitoringHandler?()
    }
    func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
        didStopMonitoringHandler?()
    }
    deinit {
        stopMonitoring()
    }
    
    func showToast(message : String, font: UIFont,target:(UIViewController)) {
        let toastLabel = UILabel(frame: CGRect(x: target.view.frame.size.width/2 - 75, y: target.view.frame.size.height-100, width: target.view.frame.size.width/2, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        target.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}
