//
//  GeneralProtocols.swift
//  WeatherTest
//
//  Created by Sergey Krasiuk on 31/01/2018.
//  Copyright © 2018 Sergey Krasiuk. All rights reserved.
//

import UIKit

// MARK: - Alertable View

protocol AlertableView {
    
    // Use handler if need catch cancel alert action
    typealias CompletionHandler = (() -> Void)
    
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]?)
    func displayAlert(with title: String, message: String, approveTitle: String, cancelTitle: String, actions: [UIAlertAction]?)
    func displayAlert(with title: String, message: String, style: UIAlertController.Style, actions: [UIAlertAction]?, completion: CompletionHandler?)
    func displayAlert(with title: String, message: String, approveTitle: String, cancelTitle: String, style: UIAlertController.Style, actions: [UIAlertAction]?, completion: CompletionHandler?)
    func displayAlert(with title: String, message: String, style: UIAlertController.Style, customActions: [UIAlertAction])
    func dispalySingleActionAlert(title: String, message: String, success: @escaping CompletionHandler)
    func displayCustomParagraphAlert(title: String, message: [String])
}

extension AlertableView where Self: UIViewController {
    
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]?) {
        DispatchQueue.main.async {
            self.displayAlert(with: title, message: message, style: .alert, actions: actions, completion: nil)
        }
    }
    
    func displayAlert(with title: String, message: String, approveTitle: String, cancelTitle: String, actions: [UIAlertAction]?) {
            self.displayAlert(with: title, message: message, approveTitle: approveTitle, cancelTitle: cancelTitle, style: .alert, actions: actions, completion: nil)
    }
    
    func displayAlert(with title: String, message: String, style: UIAlertController.Style, actions: [UIAlertAction]?, completion: CompletionHandler?) {
            self.displayAlert(with: title, message: message, approveTitle: "Close", cancelTitle: "Cancel", style: style, actions: actions, completion: completion)
    }
            
    func displayAlert(with title: String, message: String, approveTitle: String, cancelTitle: String, style: UIAlertController.Style, actions: [UIAlertAction]?, completion: CompletionHandler?) {

        DispatchQueue.main.async {
            let alertCancelAction = UIAlertAction(title: cancelTitle, style: .default) { (action) in
                
                guard let completion = completion else { return }
                completion()
            }
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
            
            if let actions = actions {
                
                for action in actions {
                    alertController.addAction(action)
                }
                
                alertController.addAction(alertCancelAction)
                
            } else {
                
                // If not any custom actions, we add OK alert button
                
                
                let alertOkAction = UIAlertAction(title: approveTitle, style: .default) { (action) in
                    
                    guard let completion = completion else { return }
                    completion()
                }
                
                alertController.addAction(alertOkAction)
            }
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func displayAlert(with title: String, message: String, style: UIAlertController.Style, customActions: [UIAlertAction]) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
            
            for action in customActions {
                alertController.addAction(action)
            }
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func dispalySingleActionAlert(title: String, message: String, success: @escaping CompletionHandler) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                success()
            })
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    func displayCustomParagraphAlert(title: String, message: [String]) {
        let paragraph: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraph.alignment = .right
        paragraph.headIndent = 10.0
        let remarksString: NSMutableAttributedString = NSMutableAttributedString(string: "", attributes: [:])
        for string in message {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(string)\n"
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
            attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraph], range: NSRange(location: 0, length: attributedString.length))
            remarksString.append(attributedString)
        }
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.setValue(remarksString, forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true)
    }


}

