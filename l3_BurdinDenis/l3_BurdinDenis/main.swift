//
//  main.swift
//  l3_BurdinDenis
//
//  Created by u on 22.12.2020.
//

import Foundation

enum MarkAuto {
    case toyota
    case kia
    case scania
    case kamaz
}
enum WindowState: String {
    case open = "Открыты"
    case closed = "Закрыты"
}

enum EngineState {
    case start
    case down
}
enum UseTrunk {
    case load(value: Double)
    case unload(value: Double)
}

struct SportCar {
    let mark: MarkAuto
    let year: Int
    let trunkVolume: Double
    var engineState: EngineState
    var windowState: WindowState {
        willSet {
            switch windowState {
            case .open:
                print("Открываем окна у \(mark)")
            case .closed:
                print("Закрываем окна у \(mark)")
            }
        }
    }
    var usedTrunkVolume: Double
    
    mutating func useVolume(move: UseTrunk) {
        switch move {
        case let .load(value):
            if (trunkVolume - usedTrunkVolume) > value {
                usedTrunkVolume += value
            } else {
                print("В \(mark) больше не влезет, можно поместить до \(trunkVolume - usedTrunkVolume) единиц веса")
            }
        case let .unload(value):
            if (usedTrunkVolume - value) < 0 {
                usedTrunkVolume = 0
                print("Вы забрали все и немного больше...")
            } else {
                usedTrunkVolume -= value
            }
        }
        print("У \(mark) иcпользованный объем багажника \(usedTrunkVolume)")
    }
    
}

struct TrunkCar {
    let mark: MarkAuto
    let year: Int
    let trunkVolume: Double
    var engineState: EngineState
    var windowState: WindowState
    var usedTrunkVolume: Double

    mutating func useWindow(action: WindowState) -> WindowState {
        switch action {
        case .open:
            windowState = .open
            return windowState
        case .closed:
            windowState = .closed
            return windowState
        }
    }
}

var kia = SportCar(mark: .kia, year: 2011, trunkVolume: 380, engineState: .down, windowState: .closed, usedTrunkVolume: 100)

var toyota = SportCar(mark: .toyota, year: 1998, trunkVolume: 240, engineState: .start, windowState: .closed, usedTrunkVolume: 0)

var kamaz = TrunkCar(mark: .kamaz, year: 2005, trunkVolume: 10000, engineState: .down, windowState: .open, usedTrunkVolume: 200)

kia.useVolume(move: .load(value: 400))
toyota.windowState = .open

let result = kamaz.useWindow(action: .closed)
switch result {
case .closed:
    print("Статус окон \(kamaz.mark): \(result.rawValue)")
case .open:
    print("Статус окон \(kamaz.mark): \(result.rawValue)")
}
