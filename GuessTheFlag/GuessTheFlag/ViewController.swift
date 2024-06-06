//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Miraç Doğan on 4.06.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numberOfQuestion = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco",
                     "nigeria","poland","russia","spain","uk","us"]
        
        [button1, button2, button3].forEach {
            $0?.imageView?.layer.borderWidth = 1
            $0?.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
        
        let scoreLabel = UILabel()
        scoreLabel.text = "Your score: \(score)"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: scoreLabel)
        
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            let ac = UIAlertController(title: title, message: "Wrong! That's the flag of \(countries[sender.tag].capitalized)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
            score -= 1
        }
        
        
        numberOfQuestion = numberOfQuestion + 1
        
        if numberOfQuestion == 11 {
            let ac = UIAlertController(title: title, message: "You answered 10 questions and your final score is \(score).", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
            
            score = 0
            numberOfQuestion = 0
        } else {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        }
        
        
    }
    
}
