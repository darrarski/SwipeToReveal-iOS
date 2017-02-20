import UIKit

class WindowSpy: UIWindow {

    private(set) var makeKeyAndVisibleCalled = false

    override func makeKeyAndVisible() {
        makeKeyAndVisibleCalled = true
    }

}
