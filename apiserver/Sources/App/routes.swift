import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let itemController = ItemController()
    router.get("items", use: itemController.index)
    router.post("items", use: itemController.create)
    router.delete("items", Item.parameter, use: itemController.delete)
    
    
    
}
