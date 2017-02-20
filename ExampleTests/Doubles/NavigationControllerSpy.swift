import UIKit

class NavigationControllerSpy: UINavigationController {

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        _didPushViewController = (viewController, animated)
    }

    private(set) var _didPushViewController: (viewController: UIViewController, animated: Bool)?

    func _reset() {
        _didPushViewController = nil
    }

}
