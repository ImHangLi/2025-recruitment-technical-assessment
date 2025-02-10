//
//  BuildingLoader.swift
//  FreeroomsAssessment
//
//  Created by Anh Nguyen on 31/1/2025.
//

import Foundation

public class BuildingLoader {
    private var client: HttpClient
    private var url: URL
    
    public enum Error: Swift.Error {
        case connectivity, invalidData
    }
    
    public typealias Result = Swift.Result<[Building], Swift.Error>
    
    public init(client: HttpClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    public func fetchBuildings() async -> Result  {
        // Make a GET request to using the HTTP client
        let result = await client.get(from: url)
        
        // Handle the result
        switch result {
        case .success(let (data, status)):
            do {
                let _ = try JSONDecoder().decode([RemoteBuilding].self, from: data)
                fatalError("TODO")
            } catch {
                return .failure(Error.invalidData)
            }
        case .failure:
            return .failure(Error.connectivity)
        }
    }
}
