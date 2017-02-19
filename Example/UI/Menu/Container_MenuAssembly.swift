import UIKit

extension Container {
    var menuAssembly: MenuAssembly {
        struct Assembly: MenuAssembly {

            var viewModel: MenuViewModel {
                return MainMenuViewModel()
            }

        }
        return Assembly()
    }
}
