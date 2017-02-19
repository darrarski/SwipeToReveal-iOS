import UIKit

extension Container {
    var menuAssembly: MenuAssembly {
        struct Assembly: MenuAssembly {

            let container: Container

            var viewModel: MenuViewModel {
                return MainMenuViewModel(assembly: self)
            }

            var tableViewExampleController: TableViewExampleController {
                return TableViewExampleController(assembly: container.tableViewExampleAssembly)
            }

        }
        return Assembly(container: self)
    }
}
