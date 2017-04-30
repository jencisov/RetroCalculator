//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Kuma on 4/29/17.
//  Copyright © 2017 Kuma. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation = Operation.Empty
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "empty "
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl =  URL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOf: soundUrl)
            buttonSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
        outputLabel.text = "0"
    }
    
    @IBAction func pressedDivide(sender: UIButton) {
        processOperation(operation: .Divide)
    }

    @IBAction func pressedMultiply(sender: UIButton) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func pressedSubtract(sender: UIButton) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func pressedAdd(sender: UIButton) {
        processOperation(operation: .Add)
    }
    
    @IBAction func pressedEquals(sender: UIButton) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func pressedClear(sender: UIButton) {
        playSound()
        outputLabel.text = "0"
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .Empty
    }
    
    @IBAction func pressedNumber(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    func playSound() {
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        buttonSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != ""  {
                rightValue = runningNumber
                runningNumber = ""
                
                switch currentOperation {
                case Operation.Multiply:
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                case Operation.Divide:
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                case Operation.Subtract:
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                case Operation.Add:
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                default:
                    result = ""
                }
                
                leftValue = result;
                outputLabel.text = result
            }
            currentOperation = operation
        } else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
}
