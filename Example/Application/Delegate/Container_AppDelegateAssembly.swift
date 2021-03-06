import UIKit

extension Container {
    var appDelegateAssembly: AppDelegateAssembly {
        struct Assembly: AppDelegateAssembly {

            let container: Container

            var window: UIWindow {
                return UIWindow(frame: UIScreen.main.bounds)
            }

            var navigationController: UINavigationController {
                return UINavigationController()
            }

            var rootViewController: UIViewController {
                return MenuViewController(assembly: container.menuAssembly)
            }

        }
        return Assembly(container: self)
    }
}
