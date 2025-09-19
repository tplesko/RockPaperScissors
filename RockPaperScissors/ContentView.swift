//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Tea Pleško on 28.04.2025..
//

import SwiftUI

struct ContentView: View {
    enum RPSChoice: String, CaseIterable, Identifiable {
        case rock = "🪨"
        case paper = "📄"
        case scissors = "✂️"

        var id: Self { self }
    }

    @State private var selectedRPS: RPSChoice = .paper
    @State private var computerChoice: RPSChoice = RPSChoice.allCases.randomElement()!
    @State private var showResultAlert = false
    @State private var resultMessage = ""
    @State private var playerScore = 0
    @State private var computerScore = 0

    var body: some View {
        VStack {
            Text("Rock Paper Scissors")
                .fontWeight(.bold)
                .font(.largeTitle)

            Spacer()

            Text("Player: \(playerScore) - Computer: \(computerScore)")
                .font(.title3)
                .padding()

            Text("Pick one below:")
                .font(.headline)

            Picker("Your choice", selection: $selectedRPS) {
                ForEach(RPSChoice.allCases) { choice in
                    Text(choice.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            Spacer()

            Button("Play") {
                playGame()
            }
            .font(.title2)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Capsule())

            Spacer()
        }
        .padding()
        .alert("Result", isPresented: $showResultAlert) {
            Button("Reset Score", role: .destructive, action: resetScores)
        } message: {
            Text("Computer chose: \(computerChoice.rawValue)\n\(resultMessage)")
        }
    }

    func playGame() {
        computerChoice = RPSChoice.allCases.randomElement()!
        resultMessage = determineResult(user: selectedRPS, computer: computerChoice)

        switch resultMessage {
        case "You Win!":
            playerScore += 1
        case "You Lose!":
            computerScore += 1
        default:
            break
        }

        showResultAlert = true
    }

    func determineResult(user: RPSChoice, computer: RPSChoice) -> String {
        if user == computer {
            return "It's a draw!"
        }

        switch (user, computer) {
        case (.rock, .scissors),
             (.scissors, .paper),
             (.paper, .rock):
            return "You Win!"
        default:
            return "You Lose!"
        }
    }

    func resetScores() {
        playerScore = 0
        computerScore = 0
    }
}

#Preview {
    ContentView()
}
