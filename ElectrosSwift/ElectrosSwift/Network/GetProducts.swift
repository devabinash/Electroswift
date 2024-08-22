import Foundation

class GetPublication {
    
    // MARK: - Init
    public init() {
    }
    
    // MARK: - Methods
    func getPublications() -> [Category] {
        let url = Bundle.main.url(forResource: "products", withExtension: "json")
        
        guard let url = url else {
            return []
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return []
        }
        
        let decoder = JSONDecoder()
        if let jsonCategories = try? decoder.decode(HomeData.self, from: data) {
            return jsonCategories.categories
        }
        
        return []
    }
}
