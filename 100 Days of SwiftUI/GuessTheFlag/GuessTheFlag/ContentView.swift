//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michael & Diana Pascucci on 12/21/22.
//
// Challenges:
// 1. Add an @State property to store the user's score, modify it when they get an answer right or wrong, then diplay it in the alert and in the score label.
// 2. When someone chooses the wrong flag, tell them their mistake in your alert message -- something like "Wrong! That's the flag of France", for example.
// 3. Make the game show only 8 questions, at which point they see a final alert judging their score and can restart the game. Note: This takes a little more thinking than the others. A good place to start would be to add a second alert() modifier watching a different Boolean property, then connect its button to a reset() method to set the game back to its initial state.

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "United Kingdom", "United States"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score: Int = 0
    @State private var questionCount: Int = 1
    @State private var isGameOver: Bool = false
    
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score) of \(questionCount - 1)")
        }
        .alert("Game Over", isPresented: $isGameOver) {
            Button("Restart", action: reset)
        } message: {
            Text("Your final score is\n\(score) of \(questionCount - 1)")
        }
    }
    
    // MARK: - METHODS
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong!\nThat is the flag of\n\(countries[number])"
        }
        
        questionCount += 1
        
        if questionCount > 8 {
            isGameOver = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        questionCount = 1
        score = 0
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
