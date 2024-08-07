import SwiftUI
import Observation

@Observable
class TriviaViewModel {
    let endpoint: String = "https://opentdb.com/api.php?amount=3&type=boolean"
    var sessionToken: String? = nil
    var encounteredAnError = false
    var trivia: AttributedString? = nil
    var timer: Timer? = nil
    let refreshEvery = 30 // In seconds, how often to grab a new trivia string.
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(refreshEvery), repeats: true) {  _ in
            Task {
                await self.getTrivia()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @MainActor
    func getTrivia() async {
        guard
            let sessionToken,
            let requestURL = URL(string: "\(endpoint)&token=\(sessionToken)")
        else {
            encounteredAnError = true
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: requestURL)
            let triviaResponse = try JSONDecoder().decode(TriviaResponse.self, from: data)
            
            if
                triviaResponse.responseCode == 0,
                let triviaItem = triviaResponse.results?.first(where: { $0.correctAnswer.lowercased() == "true" })
            {
                // Deal with API's string encoding by converting to attributed string
                guard let data = triviaItem.question.data(using: .utf8) else { return }
                let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ]
                guard let stringFromData = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
                    return
                }
                var attributedString = AttributedString(stringFromData)
                attributedString.font = .displayFont(size: 400)
                trivia = attributedString
                
            } else if triviaResponse.responseCode == 3 || triviaResponse.responseCode == 4 {
                await requestToken() // Refresh token if the response is not successful
            } else {
                return
            }
        } catch {
            encounteredAnError = true
        }
    }
    
    @MainActor
    func requestToken() async {
        guard let requestURL = URL(string: "https://opentdb.com/api_token.php?command=request") else {
            encounteredAnError = true
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: requestURL)
            let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
            
            if tokenResponse.responseCode == 0 {
                sessionToken = tokenResponse.token
                startTimer() // Start the timer only after successfully obtaining the token
                await getTrivia()
            } else {
                encounteredAnError = true
            }
        } catch {
            print("^^ Error requesting token: \(error.localizedDescription)")
            encounteredAnError = true
        }
    }
}


struct Trivia: Codable {
    let type: String
    let difficulty: String
    let category: String
    let question: String // In our case this will technically end up being a true statement
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case type
        case difficulty
        case category
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}


struct TriviaResponse: Codable {
    let responseCode: Int
    let results: [Trivia]?
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

struct TokenResponse: Codable {
    let responseCode: Int // 0 = success
    let responseMessage: String
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case responseMessage = "response_message"
        case token
    }
}
