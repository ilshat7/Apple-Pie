//
//  ViewController.swift
//  Apple Pie
//
//  Created by Ильшат Мухамедьянов on 26.10.2020.
//

import UIKit

class ViewController: UIViewController {
//MARK:- IB Outlets
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWodrLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var currentGame: Game!
    
    let incorrectMovesAllowed = 7
    var listOfWords = [
        "Андромеда",
        "Близнецы",
        "Большая Медведица",
        "Большой Пёс",
        "Весы",
        "Водолей",
        "Возничий",
        "Волк",
        "Волопас",
        "Волосы Вероники",
        "Ворон",
        "Геркулес",
        "Гидра",
        "Голубь",
        "Гончие Псы",
        "Дева",
        "Дельфин",
        "Дракон",
        "Единорог",
        "Жертвенник",
        "Живописец",
        "Жираф",
        "Журавль",
        "Заяц",
        "Змееносец",
        "Змея",
        "Золотая Рыба",
        "Индеец",
        "Кассиопея",
        "Киль",
        "Кит",
        "Козерог",
        "Компас",
        "Корма",
        "Лебедь",
        "Лев",
        "Летучая Рыба",
        "Лира",
        "Лисичка",
        "Малая Медведица",
        "Малый Конь",
        "Малый Лев",
        "Малый Пёс",
        "Микроскоп",
        "Муха",
        "Насос",
        "Наугольник",
        "Овен",
        "Октант",
        "Орёл",
        "Орион",
        "Павлин",
        "Паруса",
        "Пегас",
        "Персей",
        "Печь",
        "Райская Птица",
        "Рак",
        "Резец",
        "Рыбы",
        "Рысь",
        "Северная Корона",
        "Секстант",
        "Сетка",
        "Скорпион",
        "Скульптор",
        "Столовая Гора",
        "Стрела",
        "Стрелец",
        "Телескоп",
        "Телец",
        "Треугольник",
        "Тукан",
        "Феникс",
        "Хамелеон",
        "Центавр",
        "Цефей",
        "Циркуль",
        "Часы",
        "Чаша",
        "Щит",
        "Эридан",
        "Ящерица"].shuffled()
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    //MARK:- Methods
    
    func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func newRound() {
        guard !listOfWords.isEmpty else {
            enableButtons(false)
            updateUI()
            return
        }
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
        enableButtons()
    }
    
    func updateCorrectWordLabel() {
        var displayWord = [String]()
        for letter in currentGame.gessedWord {
            displayWord.append(String(letter))
        }
        correctWodrLabel.text = displayWord.joined(separator: " ")
    }
    
    func updateState() {
        if currentGame.incorrectMovesRemaining < 1 {
            totalLosses += 1
        } else if currentGame.gessedWord == currentGame.word {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func updateUI() {
        let movesRemaining = currentGame.incorrectMovesRemaining
        let image = "Tree\(movesRemaining < 0 ? 0 : movesRemaining < 8 ? movesRemaining : 7)"
        treeImageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.text = "Выигрышы \(totalWins), проигрышы: \(totalLosses)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    

//MARK: - IB Actions
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }
}

