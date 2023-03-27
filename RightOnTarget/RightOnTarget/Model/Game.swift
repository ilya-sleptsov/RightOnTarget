//
//  Game.swift
//  RightOnTarget
//
//  Created by Илья Слепцов on 27.03.2023.
//

import UIKit

protocol GameProtocol {
    //количество заработанных очков
    var score: Int { get }
    //загаданное значение
    var currentSecretValue: Int { get }
    //Проверка, закончена ли игра?
    var isGameEnded: Bool { get }
    //Начало новой игры и старт первого раунда
    func restartGame()
    // Начало нового раунда (обновление загаданного числа)
    func startNewRound()
    //Сравнивает переданное значение с загаданным и начисляет очки
    func calculateScore(with value: Int)
}

class Game: GameProtocol {

    var score: Int = 0
    //минимальное загаданное значение
    private var minSecretValue: Int
    //максимальное загаданное значение
    private var maxSecretValue: Int
    var currentSecretValue: Int = 0
    //количество раундов
    private var lastRound: Int
    private var currentRound: Int = 1
    var isGameEnded: Bool {
        if currentRound >= lastRound {
            return true
        } else {
            return false
        }
    }
    
    init?(startValue: Int, endValue: Int, rounds: Int) {
        //стартовое значение для выбора случайного числа не может быть больше конечного
        guard startValue <= endValue else {
            return nil
        }
        minSecretValue = startValue
        maxSecretValue = endValue
        lastRound = rounds
        currentSecretValue = self.getNewSecretValue()
    }
    
    func restartGame() {
        currentRound = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        currentSecretValue = self.getNewSecretValue()
        currentRound += 1
    }
    
    //загадать и вернуть новое случайное значение
    private func getNewSecretValue() -> Int {
        (minSecretValue...maxSecretValue).randomElement()!
    }
    
    //подсчитывает количество очков
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else  if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
            score += 50
        }
    }
        
}
