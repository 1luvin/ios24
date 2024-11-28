//
//  ViewController.swift
//  z1
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    private var input: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clear()
    }
    
    @IBAction func buttonTapped(_ button: UIButton) {
        let text = button.titleLabel!.text!
        
        switch text {
        case "C": clear()
        case "<<": erase()
        case "=": result()
        default: addToInput(text)
        }
    }
    
    private func clear() {
        input = ""
        inputLabel.text = ""
        outputLabel.text = ""
    }
    
    private func erase() {
        if input.isEmpty { return }
        
        input.removeLast()
        inputLabel.text = input
    }
    
    private func addToInput(_ text: String) {
        let t = text == "X" ? "*" : text
        
        if input.isEmpty && "/ * - +".contains(t) {
            if !outputLabel.text!.isEmpty {
                input.append(outputLabel.text!)
            }
        }
        
        input.append(t)
        inputLabel.text = input
    }
    
    private func result() {
        let expression = NSExpression(format: input)
        let result = expression.expressionValue(with: nil, context: nil) as! Double
        
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            outputLabel.text = String(format: "%.0f", result)
        } else {
            outputLabel.text = String(format: "%.2f", result)
        }
        
        input = ""
        inputLabel.text = input
    }
}

