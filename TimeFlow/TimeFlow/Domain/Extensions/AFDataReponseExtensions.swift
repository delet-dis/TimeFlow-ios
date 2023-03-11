//
//  AFDataReponseExtensions.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Alamofire
import Foundation

extension AFDataResponse {
    private func processError() -> Error {
        do {
            if let data = data,
               let responseAsDictionary =
               try JSONSerialization.jsonObject(
                   with: data, options: .allowFragments
               ) as? [String: [String]] {
                let errorMessage = responseAsDictionary.keys
                    .sorted(by: <)
                    .map { responseAsDictionary[$0]! }
                    .reduce("") { $0 + String($1.joined(separator: "\n") + "\n") }

                return NSError.createErrorWithLocalizedDescription(errorMessage)
            } else {
                return NetworkingErrorsEnum.unableToGetData
            }
        } catch {
            return NetworkingErrorsEnum.unableToGetData
        }
    }

    func processResult<T: Codable>(
        jsonDecoder: JSONDecoder,
        completion: ((Result<T, Error>) -> Void)?,
        logoutUseCase: LogoutUseCase? = nil
    ) {
        if let underlyingError = error?.asAFError?.underlyingError {
            completion?(.failure(underlyingError))

            return
        }
        if self.response?.statusCode == NetworkingConstants.wrongDataStatusCode,
           let response = data,
           let decodedError = try? jsonDecoder.decode(NetworkingError.self, from: response) {
            if let errorMessage = decodedError.messages {
                completion?(.failure(NSError.createErrorWithLocalizedDescription(errorMessage)))
            }

            return
        }
//        if self.response?.statusCode == NetworkingConstants.unauthorizedStatusCode,
//           let response = data,
//           let decodedError = try? jsonDecoder.decode(NetworkingError.self, from: response)
//        {
//            if let errorMessage = decodedError.messages {
//                completion?(.failure(NSError.createErrorWithLocalizedDescription(errorMessage)))
//            }
//
//            return
//        }

        guard let response = data else {
            if self.response?.statusCode == NetworkingConstants.successStatusCode,
               T.self == VoidResponse.self {
                // swiftlint:disable force_cast
                completion?(.success(VoidResponse() as! T))
            } else {
                completion?(.failure(NetworkingErrorsEnum.unableToGetData))
            }

            return
        }

        do {
            let decodedResponse = try jsonDecoder.decode(T.self, from: response)

            completion?(.success(decodedResponse))
        } catch {
            completion?(.failure(error))
        }
    }
}
