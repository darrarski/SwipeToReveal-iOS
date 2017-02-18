import UIKit

extension Container {
    var appDelegateAssembly: AppDelegateAssembly {
        struct Assembly: AppDelegateAssembly {

            let container: Container

            var window: UIWindow {
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController = TableViewExampleController(assembly: container.tableViewExampleAssembly)
                return window
            }

        }
        return Assembly(container: self)
    }
}
