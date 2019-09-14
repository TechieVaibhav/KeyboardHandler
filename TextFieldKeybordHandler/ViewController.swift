//
//  ViewController.swift
//  TextFieldKeybordHandler
//
//  Created by Mohit Shrama on 14/09/19.
//  Copyright © 2019 vaibhav sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var activeTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.activeTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        manageContentInset(notification: notification)
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        resetContentInset()
    }
    
    func manageContentInset(notification:NSNotification) {
        UIView.animate(withDuration: 0.2) {
            let userInfo = notification.userInfo!
            
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            
            let changeInHeight = (keyboardFrame.height + 40)
            
            self.scrollView.contentInset.bottom += changeInHeight
            
            self.scrollView.scrollIndicatorInsets.bottom += changeInHeight; self.view.layoutIfNeeded()
        }
        
    }
    
    func resetContentInset() {
        UIView.animate(withDuration: 0.2) {
            self.scrollView.contentInset = .zero
            self.scrollView.scrollIndicatorInsets = .zero
            self.view.layoutIfNeeded()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.activeTextField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
