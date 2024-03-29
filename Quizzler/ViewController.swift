//
//  ViewController.swift
//  Quizzler
//
//  Created by Qiniso Luthuli on 2017/09/15.
//  Copyright © 2017 Qiniso Luthuli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
  
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber = questionNumber + 1
        
        nextQuestion()
        
    }
    
    
    func updateUI() {
      
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
        
        if questionNumber <= 12 {
          questionLabel.text = allQuestions.list[questionNumber].questionText
          updateUI()
        }
        else {
            
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions. Do you want to start again?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()

            })
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].anwser
        
        if correctAnswer == pickedAnswer {
            
            ProgressHUD.showSuccess("Correct!")
            score = score + 1
        }
        else {
            ProgressHUD.showError("Incorrect!")
        }

        
    }
    
    
    func startOver() {
        
        questionNumber = 0
        nextQuestion()
        score = 0
        scoreLabel.text = "Score: \(self.score)"
    }
    

    
}
