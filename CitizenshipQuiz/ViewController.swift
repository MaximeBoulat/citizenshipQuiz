//
//  ViewController.swift
//  CitizenshipQuiz
//
//  Created by Maxime Boulat on 4/19/19.
//  Copyright © 2019 Maxime Boulat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var endTurn: () -> Void = {}


	var currentItem: QuizItem! {
		didSet {
			self.viewPort.textColor = .black
			self.viewPort.text = currentItem.question
		}
	}
	
	var revealAnswer: Bool = true
	
	@IBOutlet weak var viewPort: UILabel!
	@IBAction func didPressNext(_ sender: Any) {
		if revealAnswer {
			self.viewPort.textColor = .blue
			self.viewPort.text = currentItem.answer
		} else {
			endTurn()
		}
		
		revealAnswer = !revealAnswer
	}
	
	
}

extension ViewController: QuizViewable {
	
	func displayPair(item: QuizItem) {
		self.currentItem = item
	}
	
	func endGame(completion: @escaping () -> Void) {
		
		let alert = UIAlertController(title: nil, message: "Game has ended. play again?", preferredStyle: .alert)
		let ok = UIAlertAction(title: "Okay", style: .default) { (action)  in
			
			completion()
		}
		alert.addAction(ok)
		self.present(alert, animated: true, completion: nil)
	}
}

