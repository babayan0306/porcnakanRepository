//
//  ViewController.swift
//  UltraCalculatorProject
//
//  Created by Yurka Babayan on 28.02.23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var actionLbl: UILabel!
    
  
    var stillTyping: Bool = false
    var dotIsPlaced: Bool = false
    var firstOperand: Double = 0
    var esEm: String = ""
    var operatorSign: String = ""
    var currentInput: Double {
        get {
            return Double(actionLbl.text!)!
        }
        
        set {
            actionLbl.text = "\(newValue)"
            stillTyping = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func symbols(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        actionLbl.text = "0"
        stillTyping = false
        dotIsPlaced = false
        operatorSign = ""
    }
    
    @IBAction func plusMInusButtonPress(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func persentageButton(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
    }
    
    @IBAction func squareRootButtonPrees(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    
    @IBAction func dotButtonPress(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            actionLbl.text = actionLbl.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            actionLbl.text = "0."
        }
    }
    
    @IBAction func numbersAction(_ sender: UIButton) {
        
        let number = sender.currentTitle!
    
        if stillTyping {
            if actionLbl.text!.count <= 20 {
                actionLbl.text = actionLbl.text! + number
            }
        } else {
            actionLbl.text = number
            stillTyping = true
        }
    }
    
    
    @IBAction func twoOperandsSignPress(_ sender: UIButton) {
        operatorSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func equalitySignPress(_ sender: UIButton) {
        
        if stillTyping {
            secondOperand = currentInput
        }
        
        currentInput *= currentInput
        
        dotIsPlaced = false
        
        switch operatorSign {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "÷":
            operateWithTwoOperands{$0 / $1}
        case "x":
            operateWithTwoOperands{$0 * $1}
        default: break
        }
    }
}
    



