import UIKit

extension Container {
    var menuAssembly: MenuAssembly {
        struct Assembly: MenuAssembly {

            let container: Container

            var viewModel: MenuViewModel {
                return MainMenuViewModel(assembly: self)
            }

            var tableExampleViewController: UIViewController {
                return TableExampleViewController(assembly: container.tableExampleAssembly)
            }

        }
        return Assembly(container: self)
    }
}
