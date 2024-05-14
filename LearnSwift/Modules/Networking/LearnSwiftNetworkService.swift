import Foundation

public enum RequestError: Error  {
    case invalidURL(String)
    case error(String)
    case unknownHTTPError(Int)
    case badRequest
    case authenticationError
    case forbidden
    case serverError(String)
}
public protocol LearnSwiftService {
    func fetchFoodCategories() async throws -> [FoodCategory]
    func fetchFoodItems(foodCategory: FoodCategory) async throws -> [FoodItem]
    func fetchFoodRecipe(foodItem: FoodItem) async throws -> FoodRecipe
}

public class LearnSwiftNetworkService: LearnSwiftService {
    
    public init() {}
    
    public func fetchFoodCategories() async throws -> [FoodCategory] {
        guard let urlRequest =  LearnSwiftEndpoint.getCategories().request
        else {
            throw RequestError.invalidURL("Unable to create FoodCategoryURL")
        }
        
        return try await withCheckedThrowingContinuation({ continuation in
            LearnSwiftSessionDelegate.shared.sharedSession.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else {
                    if let error = error {
                        print(error)
                        continuation.resume(throwing: error)
                    }
                    return
                }
                
                guard let httpReponse = response as? HTTPURLResponse else {
                    continuation.resume(throwing: RequestError.error("Invalid Response"))
                    return
                }
                
                var requestError: RequestError?
                
                switch httpReponse.statusCode {
                case 200...299:
                    if let data = data {
                        do {
                            let foodCategories = try JSONDecoder().decode([FoodCategory].self, from: data)
                            continuation.resume(returning: foodCategories)
                        } catch let error {
                            let str = String(decoding: data, as: UTF8.self)
                            print("Quote decode error. Data contents are: \(str)")
                            continuation.resume(throwing: error)
                        }
                    }
                case 400:
                    requestError = RequestError.badRequest
                case 401:
                    requestError = RequestError.authenticationError
                case 403:
                    requestError = RequestError.forbidden
                case 500...504:
                    requestError = RequestError.serverError("Internal Server Error")
                default:
                    requestError = RequestError.unknownHTTPError(httpReponse.statusCode)
                    print(httpReponse.statusCode)
                }
                
                if let requestError = requestError {
                    continuation.resume(throwing: requestError)
                }
                
            }.resume()
        })
    }
    
    public func fetchFoodItems(foodCategory: FoodCategory) async throws -> [FoodItem] {
        guard let urlRequest =  LearnSwiftEndpoint.getFoodItems(category: foodCategory).request
        else {
            throw RequestError.invalidURL("Unable to create FoodItemURL")
        }
        
        return try await withCheckedThrowingContinuation({ continuation in
            LearnSwiftSessionDelegate.shared.sharedSession.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else {
                    if let error = error {
                        continuation.resume(throwing: error)
                    }
                    return
                }
                
                guard let httpReponse = response as? HTTPURLResponse else {
                    continuation.resume(throwing: RequestError.error("Invalid Response"))
                    return
                }
                
                var requestError: RequestError?
                
                switch httpReponse.statusCode {
                case 200...299:
                    if let data = data {
                        do {
                            let foodItems = try JSONDecoder().decode([FoodItem].self, from: data)
                            continuation.resume(returning: foodItems)
                        } catch let error {
                            let str = String(decoding: data, as: UTF8.self)
                            print("Quote decode error. Data contents are: \(str)")
                            continuation.resume(throwing: error)
                        }
                    }
                case 400:
                    requestError = RequestError.badRequest
                case 401:
                    requestError = RequestError.authenticationError
                case 403:
                    requestError = RequestError.forbidden
                case 500...504:
                    requestError = RequestError.serverError("Internal Server Error")
                default:
                    requestError = RequestError.unknownHTTPError(httpReponse.statusCode)
                }
                
                if let requestError = requestError {
                    continuation.resume(throwing: requestError)
                }
                
            }.resume()
        })
    }
    
    public func fetchFoodRecipe(foodItem: FoodItem) async throws -> FoodRecipe{
        guard let urlRequest =  LearnSwiftEndpoint.getFoodRecipe(foodItem: foodItem).request
        else {
            throw RequestError.invalidURL("Unable to create FoodRecipeURL")
        }
        
        return try await withCheckedThrowingContinuation({ continuation in
            LearnSwiftSessionDelegate.shared.sharedSession.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else {
                    if let error = error {
                        continuation.resume(throwing: error)
                    }
                    return
                }
                
                guard let httpReponse = response as? HTTPURLResponse else {
                    continuation.resume(throwing: RequestError.error("Invalid Response"))
                    return
                }
                
                var requestError: RequestError?
                
                switch httpReponse.statusCode {
                case 200...299:
                    if let data = data {
                        do {
                            let foodRecipe = try JSONDecoder().decode(FoodRecipe.self, from: data)
                            continuation.resume(returning: foodRecipe)
                        } catch let error {
                            let str = String(decoding: data, as: UTF8.self)
                            print("Quote decode error. Data contents are: \(str)")
                            continuation.resume(throwing: error)
                        }
                    }
                case 400:
                    requestError = RequestError.badRequest
                case 401:
                    requestError = RequestError.authenticationError
                case 403:
                    requestError = RequestError.forbidden
                case 500...504:
                    requestError = RequestError.serverError("Internal Server Error")
                default:
                    requestError = RequestError.unknownHTTPError(httpReponse.statusCode)
                }
                
                if let requestError = requestError {
                    continuation.resume(throwing: requestError)
                }
                
            }.resume()
        })
    }
}
