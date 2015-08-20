//
//  ViewController.swift
//  Tip
//
//  Created by Lin Wang on 6/19/15.
//  Copyright (c) 2015 Lin Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var billLabel: UILabel!
    var billAmountString: NSString! = ""
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var numOneButton: UIButton!
    @IBOutlet weak var numTwoButton: UIButton!
    @IBOutlet weak var numThreeButton: UIButton!
    @IBOutlet weak var numFourButton: UIButton!
    @IBOutlet weak var numFiveButton: UIButton!
    @IBOutlet weak var numSixButton: UIButton!
    @IBOutlet weak var numSevenButton: UIButton!
    @IBOutlet weak var numEightButton: UIButton!
    @IBOutlet weak var numNineButton: UIButton!
    @IBOutlet weak var numZeroButton: UIButton!
    @IBOutlet weak var numDotButton: UIButton!
    @IBOutlet weak var numDeleteButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0"
        totalLabel.text = "0"
        
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        
        var billAmount = billAmountString.doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        
        tipLabel.text = String(format:"$%.2f", tip)
        totalLabel.text = String(format:"%.2f", total)
        
        
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onNumButtonTap(sender: UIButton) {
        var newBillAmountString: String!
        
        switch sender.tag {
        case 0:
            fatalError("button doesn't have a tag!")
        case 1:
            newBillAmountString = billAmountString.stringByAppendingString("1")
        case 2:
            newBillAmountString = billAmountString.stringByAppendingString("2")
        case 3:
            newBillAmountString = billAmountString.stringByAppendingString("3")
        case 4:
            newBillAmountString = billAmountString.stringByAppendingString("4")
        case 5:
            newBillAmountString = billAmountString.stringByAppendingString("5")
        case 6:
            newBillAmountString = billAmountString.stringByAppendingString("6")
        case 7:
            newBillAmountString = billAmountString.stringByAppendingString("7")
        case 8:
            newBillAmountString = billAmountString.stringByAppendingString("8")
        case 9:
            newBillAmountString = billAmountString.stringByAppendingString("9")
        case 10:
            newBillAmountString = billAmountString.stringByAppendingString("0")
        case 11:
            newBillAmountString = billAmountString.stringByAppendingString(".")
        case 12:
            newBillAmountString = billAmountString.length <= 1 ? "" : billAmountString.substringToIndex(billAmountString.length-1)
        default:
            break
        }
        
        let isInputValid = validateInput(newBillAmountString)
        if isInputValid {
            billAmountString = newBillAmountString
            billLabel.text = "$" + (count(newBillAmountString) == 0 ? "0" : newBillAmountString)
        } else {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.05
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(CGPoint: CGPointMake(billLabel.center.x - 10, billLabel.center.y))
            animation.toValue = NSValue(CGPoint: CGPointMake(billLabel.center.x + 10, billLabel.center.y))
            billLabel.layer.addAnimation(animation, forKey: "position")
        }
        onEditingChanged(billLabel)
        
        self.totalLabel.alpha = 0.1
        UIView.animateWithDuration(1.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.totalLabel.alpha = 1
        }, completion:nil)
        
        
        UIView.animateWithDuration(0.9, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: .CurveLinear, animations: {
            
            self.totalLabel.center = CGPoint(x: 200, y:60 )
            }, completion: nil)
        
    }

    func validateInput(input: String) -> Bool {
        let validInputRegEx: NSRegularExpression = NSRegularExpression(pattern: "^([0-9]{0,4}\\.[0-9]{0,2}|[0-9]{0,4})$", options: NSRegularExpressionOptions.CaseInsensitive, error: nil)!
        let range = NSRange(location:0, length:input.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let matchNum = validInputRegEx.numberOfMatchesInString(input, options: nil, range: range)
        
        var allow = (matchNum == 1)
        return allow
    }
    
    
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        let text = textField.text as NSString!
//        let newText = text.stringByReplacingCharactersInRange(range, withString: string)
//        
//        
//        onEditingChanged(textField)
//        return allow
//    }

}

