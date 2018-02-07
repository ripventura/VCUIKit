//
//  VCTextField.swift
//  Pods
//
//  Created by Vitor Cesco on 19/07/17.
//
//

import UIKit

@IBDesignable open class VCTextField: UITextField {
    public struct ToolbarItem {
        public var name: String
        public var selector: () -> Void
        
        public init(name: String, selector: @escaping () -> Void) {
            self.name = name
            self.selector = selector
        }
    }
    /** Whether the appearance is being set manually on Storyboard */
    @IBInspectable public var storyboardAppearance: Bool = false
    /** Whether a toolbar should appear above the keyboard */
    @IBInspectable public var needsToolbar: Bool = false {
        didSet {
            self.setAccessoryView()
        }
    }
    public var toolbarAccessoryItem: ToolbarItem? {
        didSet {
            self.setAccessoryView()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.applyAppearance()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.applyAppearance()
    }
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.applyAppearance()
    }
    
    override open func applyAppearance() -> Void {
        super.applyAppearance()
        
        if !storyboardAppearance {
            self.textColor = sharedAppearanceManager.appearance.textFieldTextColor
            self.font = sharedAppearanceManager.appearance.textFieldTextFont
        }
    }
    
    @objc func toolbarDoneButtonPressed() {
        if let toolbarItem = self.toolbarAccessoryItem {
            toolbarItem.selector()
        }
    }
    
    /** Sets a Toolbar as InputAccessoryView */
    func setAccessoryView() {
        if self.needsToolbar {
            let keyboardDoneButtonShow = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
            keyboardDoneButtonShow.barStyle = .default
            
            var doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                             target: self,
                                             action: #selector(resignFirstResponder))
            if let toolbarItem = self.toolbarAccessoryItem {
                doneButton = UIBarButtonItem(title: toolbarItem.name,
                                             style: .done,
                                             target: self,
                                             action: #selector(toolbarDoneButtonPressed))
            }
            
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            keyboardDoneButtonShow.setItems([flexSpace,doneButton], animated: false)
            
            self.inputAccessoryView = keyboardDoneButtonShow
        }
        else {
            self.inputAccessoryView = nil
        }
    }
}
