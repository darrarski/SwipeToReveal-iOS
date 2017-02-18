import UIKit

protocol AppDelegateAssembly {
    var window: UIWindow { get }
    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController { get }
}
