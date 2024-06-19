//
//  EmailController.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import Foundation
import MessageUI

public class EmailController: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = EmailController()
    public override init() { }
    
    func sendEmail(subject:String, body:String, to:String){
        // Check if the device is able to send emails
        if !MFMailComposeViewController.canSendMail() {
            print("This device cannot send emails.")
            return
        }
        // Create the email composer
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients([to])
        mailComposer.setSubject(subject)
        mailComposer.setMessageBody(body, isHTML: false)
        //EmailController.getRootViewController()?.present(mailComposer, animated: true, completion: nil)
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            //EmailController.getRootViewController()?.dismiss(animated: true, completion: nil)
    }
    /*func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }*/

    
    
    /*static func getRootViewController() -> UIViewController? {
            // In SwiftUI 2.0
        UIApplication.shared.windows.first?.rootViewController
        
    }*/
}
