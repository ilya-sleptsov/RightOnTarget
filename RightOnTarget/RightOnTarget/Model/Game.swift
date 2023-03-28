//
//  Game.swift
//  RightOnTarget
//
//  Created by Илья Слепцов on 27.03.2023.
//

//Сущность "Игра"

protocol GameProtocol {
    //количество заработанных очков
    var score: Int { get }
    //загаданное значение
    var currentRound: GameRoundProtocol! { get }
    //Проверка, закончена ли игра?
    var isGameEnded: Bool { get }
    //Генератор случайного значения
    var secretValueGenerator: GeneratorProtocol { get }
    //Начало новой игры и старт первого раунда
    func restartGame()
    // Начало нового раунда (обновление загаданного числа)
    func startNewRound()

}

class Game: GameProtocol {

    var score: Int {
        var totalScore: Int = 0
        for round in self.rounds {
            totalScore += round.score
        }
        return totalScore
    }
    var currentRound: GameRoundProtocol!
    private var rounds: [GameRoundProtocol] = []
    var secretValueGenerator: GeneratorProtocol
    private var roundsCount: Int!
    var isGameEnded: Bool {
        if roundsCount == rounds.count {
            return true
        } else {
            return false
        }
    }
   
    
    init(valueGenerator: GeneratorProtocol, rounds: Int) {
        secretValueGenerator = valueGenerator
        roundsCount = rounds
        startNewRound()
        }
        
    func restartGame() {
     rounds = []
        startNewRound()
    }
    
    func startNewRound() {
        let newSecretValue = self.getNewSecretValue()
        currentRound = GameRound(secretValue: newSecretValue)
        rounds.append(currentRound)
    }
    
    //загадать и вернуть новое случайное значение
    private func getNewSecretValue() -> Int {
        return secretValueGenerator.getRandomValue()
    }
}
