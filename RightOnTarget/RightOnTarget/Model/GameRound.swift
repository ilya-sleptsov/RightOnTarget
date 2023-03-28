//
//  GameRound.swift
//  RightOnTarget
//
//  Created by Илья Слепцов on 28.03.2023.
//

//Сущность "Раунд"

import Foundation

protocol GameRoundProtocol {
    //количество заработанных очков
    var score: Int { get }
    //загаданное значение
    var currentSecretValue: Int { get }
    //сравнивает переданное значение с загаданным и начисляет очки
    func calculateScore(with value: Int)
}

class GameRound: GameRoundProtocol {

    var score: Int = 0
    var currentSecretValue: Int = 0
    
    init(secretValue: Int) {
        currentSecretValue = secretValue
    }
    
    //подсчет количества очков
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score = 50 - value + currentSecretValue
        } else  if value < currentSecretValue {
            score = 50 - currentSecretValue + value
        } else {
            score = 50
        }
    }
}
