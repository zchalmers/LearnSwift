import UIKit

public class LearnSwiftSessionDelegate: NSObject {
    let baseUrl = "http://192.168.1.90:8080"
    
    // Singleton
    // lazy by default
    public static private(set) var shared: LearnSwiftSessionDelegate = LearnSwiftSessionDelegate()
    
    public lazy var sharedSession: URLSession = {
        [weak self] in
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 60.0
        sessionConfig.timeoutIntervalForResource = 60.0
        
        var session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let url = URL(string: baseUrl) else { 
            return session
        }
                
        
        return session
        }()
}
