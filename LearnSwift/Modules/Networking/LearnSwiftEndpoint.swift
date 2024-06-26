import Foundation

struct LearnSwiftEndpoint: Endpoint {
    
    let host: String
    var path: String
    var queryItems: [URLQueryItem]?
    var httpMethod: HttpMethod = .GET
    var httpHeaders: [(key: HttpRequestHeaderKey, value: String)]?
    var body: Data?
    
//    init(host: String = "192.168.1.90", path: String, queryItems: [URLQueryItem]?,
//         httpMethod: HttpMethod = .GET, httpHeaders: [(key: HttpRequestHeaderKey, value: String)]? = nil) {
//
//        self.host = host
//        self.path = path
//        self.httpMethod = httpMethod
//        self.queryItems = queryItems
//        self.httpHeaders = httpHeaders
//    }
    
//    init(host: String = "99.8.107.171", path: String, queryItems: [URLQueryItem]?,
//         httpMethod: HttpMethod = .GET, httpHeaders: [(key: HttpRequestHeaderKey, value: String)]? = nil) {
//
//        self.host = host
//        self.path = path
//        self.httpMethod = httpMethod
//        self.queryItems = queryItems
//        self.httpHeaders = httpHeaders
//    }
    
    init(host: String = "10.0.0.23", path: String, queryItems: [URLQueryItem]?,
         httpMethod: HttpMethod = .GET, httpHeaders: [(key: HttpRequestHeaderKey, value: String)]? = nil) {
        
        self.host = host
        self.path = path
        self.httpMethod = httpMethod
        self.queryItems = queryItems
        self.httpHeaders = httpHeaders
    }
}

extension LearnSwiftEndpoint {
    
    enum FoodPaths: String {
        case foodCategories = "/foodCategoriesList"
        case foodItems = "/foodItems"
        case foodRecipe = "/foodRecipe"
    }
    
    static func getCategories() -> LearnSwiftEndpoint {
        
        let headers: [(key: HttpRequestHeaderKey, value: String)] =
        [(key: .content_type, value: "application/json"),
         (key: .accept, value: "application/json")]
        
        return LearnSwiftEndpoint(path: FoodPaths.foodCategories.rawValue, queryItems: nil, httpMethod: HttpMethod.GET, httpHeaders: headers)
    }
    
    static func getFoodItems(category: FoodCategory) -> LearnSwiftEndpoint {
        
        let headers: [(key: HttpRequestHeaderKey, value: String)] =
        [(key: .content_type, value: "application/json"),
         (key: .accept, value: "application/json")]
        let queryItems = [
            URLQueryItem(name: "id", value: category.id)
        ]
        return LearnSwiftEndpoint(path: FoodPaths.foodItems.rawValue, queryItems: queryItems, httpMethod: HttpMethod.GET, httpHeaders: headers)
    }
    static func getFoodRecipe(foodItem: FoodItem) -> LearnSwiftEndpoint {
        
        let headers: [(key: HttpRequestHeaderKey, value: String)] =
        [(key: .content_type, value: "application/json"),
         (key: .accept, value: "application/json")]
        let queryItems = [
            URLQueryItem(name: "id", value: foodItem.id)
        ]
        return LearnSwiftEndpoint(path: FoodPaths.foodRecipe.rawValue, queryItems: queryItems, httpMethod: HttpMethod.GET, httpHeaders: headers)
    }
    
}
