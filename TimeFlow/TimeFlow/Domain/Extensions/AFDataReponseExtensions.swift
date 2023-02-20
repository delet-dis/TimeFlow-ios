//
//  AFDataReponseExtensions.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Alamofire
import Foundation

extension AFDataResponse {
    func processResult<T: Codable>(
        jsonDecoder: JSONDecoder,
        completion: ((Result<T, Error>) -> Void)?,
        logoutUseCase: LogoutUseCase? = nil
    ) {
        if let underlyingError = self.error?.asAFError?.underlyingError {
            completion?(.failure(underlyingError))

            return
        }

        if self.response?.statusCode == NetworkingConstants.unauthorizedStatusCode {
            // TODO: Add passing user credentials
            //            logoutUseCase?.execute { _ in
            //                completion?(.failure(NetworkingErrorsEnum.wrongUserCredentials))
            //            }

            return
        }

        guard let response = self.data else {
            if self.response?.statusCode == NetworkingConstants.successStatusCode,
               T.self == VoidResponse.self {
                // swiftlint:disable force_cast
                completion?(.success(VoidResponse() as! T))
            } else {
                completion?(.failure(NetworkingErrorsEnum.unableToGetData))
            }

            return
        }

        if case .failure = self.result {
            do {
                let decodedError = try jsonDecoder.decode(NetworkingError.self, from: response)

                if let errorMessage = decodedError.message {
                    completion?(.failure(
                        NSError.createErrorWithLocalizedDescription(errorMessage)
                    ))

                    return
                }
            } catch {
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
