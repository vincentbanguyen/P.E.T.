import SwiftUI

struct Quote: Codable {
    var q: String
    var a: String
    var h: String
}

enum ApiError: Error {
    case dataIsNil
}

class QuoteApi {
    func getQuotes(completion:@escaping (Result<Quote, Error>) -> ()) {
        let urlSession = URLSession(configuration: .ephemeral)

        guard let url = URL(string:"https://zenquotes.io/api/random/1dad0b965a5a6423a3fa182d8c48277f300f4c36") else { return }

        urlSession.dataTask(with: url) { (data, _, error) in
                    if let error = error {
                        print(error)
                        completion(.failure(error))
                        return
                    }
                    guard let data = data else {
                        print("data is nil")
                        completion(.failure(ApiError.dataIsNil))
                        return
                    }
            do {
                let quotes = try JSONDecoder().decode(Quote.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(quotes))
                }
                print(quotes)
            } catch {
                print("UH OH")
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
