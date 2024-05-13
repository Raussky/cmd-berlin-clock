//
//  main.swift
//  homework2
//
//  Created by Admin on 03.04.2023.
//


import Foundation

struct Clock {
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
}

protocol ClockGameProtocol {
    func play(clock: Clock) -> String
}


struct BerlinClockGame: ClockGameProtocol {
    func play(clock: Clock) -> String {
        var output = ""
        var line0 = "Y"
        let line1 = numberToLights(clock.hours / 5, maxLights: 4)
        let line2 = numberToLights(clock.hours % 5, maxLights: 4)
        var line3 = ""
        let line4 = numberToLights(clock.minutes % 5, maxLights: 4)

        if clock.seconds % 2 == 0 {
            line0 = "O"
        }

        if clock.minutes >= 5 {
            let numLights = clock.minutes / 5
            for i in 0..<numLights {
                if (i + 1) % 3 == 0 {
                    line3 += "R"
                } else {
                    line3 += "Y"
                }
            }
            line3 = padLights(line3, maxLights: 11)
        } else {
            line3 = "OOROOROOROO"
        }

        output = line0 + line1 + line2 + line3 + line4
        return output
    }

    private func numberToLights(_ number: Int, maxLights: Int) -> String {
        var lights = ""
        for _ in 0..<number {
            lights += "Y"
        }
        for _ in number..<maxLights {
            lights += "O"

        }
        return lights
    }

    private func padLights(_ lights: String, maxLights: Int) -> String {
        var padded = lights
        for i in lights.count..<maxLights {
            if (i + 1) % 3 == 0 {
                padded += "R"
            }
            else {
                padded += "O"
            }
        }
        return padded
    }
}

func promptForClockInput() -> Clock? {
    var hours: Int?
    var minutes: Int?
    var seconds: Int?
    while hours == nil {
        print("Enter the number of hours: ")
        guard let hoursInput = readLine(),
              let inputHours = Int(hoursInput) else {
            print("Invalid input. Please try again.")
            continue
        }
        hours = inputHours
    }
    while minutes == nil {
        print("Enter the number of minutes: ")
        guard let minutesInput = readLine(),
              let inputMinutes = Int(minutesInput) else {
            print("Invalid input. Please try again.")
            continue
        }
        minutes = inputMinutes
    }
    while seconds == nil {
        print("Enter the number of seconds: ")
        guard let secondsInput = readLine(),
              let inputSeconds = Int(secondsInput) else {
            print("Invalid input. Please try again.")
            continue
        }
        seconds = inputSeconds
    }

    return Clock(hours: hours!, minutes: minutes!, seconds: seconds!)
}


let example2 = BerlinClockGame()
while true {
    guard let inputClock = promptForClockInput() else {
        break
    }
    let result = example2.play(clock: inputClock)
    print(result)
}
