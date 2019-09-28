//
//  File.swift
//  CitizenshipQuiz
//
//  Created by Maxime Boulat on 4/19/19.
//  Copyright © 2019 Maxime Boulat. All rights reserved.
//

import Foundation

protocol QuizViewable {
	
	func displayPair(item: QuizItem)
	func endGame(completion: @escaping () -> Void)
	var endTurn: () -> Void { get set }
	
	
}

struct QuizItem {
	
	var question: String
	var answer: String
	
}

protocol DataProviding {
	
	
	func resetDeck()
	func getPair() -> QuizItem?
	
}


class QuizPresenter {
	
	var view: QuizViewable
	var dataProvider: DataProviding
	
	init(view: QuizViewable, dataProvider: DataProviding) {
		self.view = view
		self.dataProvider = dataProvider
		
		self.view.endTurn = { [weak self] in
			
			if let pair = dataProvider.getPair() {
				self?.view.displayPair(item: pair)
			}
			else {
				self?.view.endGame(completion: {[weak self] in
					self?.start()
				})
			}
		}
	}
	
	
	func start() {
	
		dataProvider.resetDeck()
		
		if let pair = dataProvider.getPair() {
			view.displayPair(item: pair)
		}
		else {
			view.endGame(completion: {[weak self] in
				self?.start()
			})
		}
	}
	
}

