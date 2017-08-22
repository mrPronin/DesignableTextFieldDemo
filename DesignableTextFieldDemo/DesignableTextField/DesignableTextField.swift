//
//  DesignableTextField.swift
//  DesignableTextField
//
//  Created by Oleksandr Pronin on 21.08.17.
//  Copyright © 2017 Oleksandr Pronin. All rights reserved.
//

// Inspired by
/*
Create an IBDesignable UIView subclass with code from an XIB file in Xcode 6
http://supereasyapps.com/blog/2014/12/15/create-an-ibdesignable-uiview-subclass-with-code-from-an-xib-file-in-xcode-6

Tutorial: Building Your Own Custom IBDesignable View: A UITextView With Placeholder
https://digitalleaves.com/blog/2015/02/tutorial-building-your-own-custom-ibdesignable-view-a-uitextview-with-placeholder/
*/

import UIKit

@IBDesignable class DesignableTextField: UIView
{
    //MARK: Public API
    
    @IBInspectable var color: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = color.cgColor
            self.titleLabel.textColor = color
            self.textField.placeholderColor = color
            setNeedsLayout()
        }
    }
    
    @IBInspectable var background: UIColor? {
        get {
            return self.view.backgroundColor
        }
        set(newColor) {
            self.view.backgroundColor = newColor
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
            setNeedsLayout()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            setNeedsLayout()
        }
    }
    
    @IBInspectable var title: String? {
        get {
            return self.titleLabel.text
        }
        set(newTitle) {
            self.titleLabel.text = newTitle
        }
    }
    
    @IBInspectable var text: String? {
        get {
            return self.textField.text
        }
        set(newText) {
            self.textField.text = newText
            setNeedsLayout()
        }
    }
    
    @IBInspectable var textColor: UIColor? {
        get {
            return self.textField.textColor
        }
        set(newColor) {
            self.textField.textColor = newColor
            setNeedsLayout()
        }
    }
    
    @IBInspectable var placeholder: String? {
        get {
            return self.textField.placeholder
        }
        set(newPlaceholder) {
            self.textField.placeholder = newPlaceholder
            self.textField.placeholderColor = self.color
            setNeedsLayout()
        }
    }
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var textField: UITextField!
    
    fileprivate var view: UIView!
    
    override init(frame: CGRect)
    {
        print("[\(type(of: self)) \(#function)]")
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        self.xibSetup()
        
        self.setupViewsOnLoad()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        print("[\(type(of: self)) \(#function)]")
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        self.xibSetup()
        
        self.setupViewsOnLoad()
    }
    
    // MARK: - Private
    
    fileprivate func xibSetup()
    {
        let className = String.className(type(of: self))
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: className, bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        // use bounds not frame or it'll be offset
        self.view.frame = bounds
        
        // Make the view stretch with containing view
        self.view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(self.view)
    }
    
    fileprivate func setupViewsOnLoad()
    {
        // Default falues
        self.color = UIColor.lightGray
        self.background = UIColor.white
        self.borderWidth = 1.0
        self.cornerRadius = 4.0
    }
}

