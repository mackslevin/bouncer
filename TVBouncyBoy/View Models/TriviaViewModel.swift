import SwiftUI
import Observation

@Observable
final class TriviaViewModel {
    let endpoint: URL? = URL(string:"https://uselessfacts.jsph.pl/api/v2/facts/random")
    var timer: Timer?
    var encounteredAnError = false
    var trivia: AttributedString?
    let refreshInterval = 30 // In seconds
    
    struct TriviaResponse: Codable {
        let id: String
        let text: String
        let source: String?
        let sourceUrl: String?
        let language: String
        let permalink: String

        enum CodingKeys: String, CodingKey {
            case id
            case text
            case source
            case sourceUrl = "source_url"
            case language
            case permalink
        }
    }
    
    func getTrivia() async {
        guard let endpoint else { encounteredAnError = true; return }
        do {
            let (data, _) = try await URLSession.shared.data(from: endpoint)
            let triviaResponse = try JSONDecoder().decode(TriviaResponse.self, from: data)
            if !triviaResponse.text.isEmpty {
                // Deal with string encoding
                guard let data = triviaResponse.text.data(using: .utf8) else { return }
                let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ]
                guard let stringFromData = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
                    return
                }
                var attributedString = AttributedString(stringFromData)
                attributedString.font = .displayFont(size: 500) // View applies minimum scale factor to bring it down to largest appropriate size
                
                trivia = attributedString
            } else {
                trivia = nil
            }
        } catch {
            print(error)
            encounteredAnError = true
        }
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(refreshInterval), repeats: true) {  _ in
            Task {
                await self.getTrivia()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
