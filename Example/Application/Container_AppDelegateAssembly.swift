import UIKit

extension Container {
    var appDelegateAssembly: AppDelegateAssembly {
        struct Assembly: AppDelegateAssembly {

            var window: UIWindow {
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController = TableViewController()
                return window
            }

        }
        return Assembly()
    }
}
