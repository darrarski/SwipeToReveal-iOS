import UIKit

class MainMenuViewModel: MenuViewModel, MenuItemViewModelDelegate {

    init(assembly: MenuAssembly) {
        self.assembly = assembly
        tableViewExample.delegate = self
    }

    weak var delegate: MenuViewModelDelegate?
    private let assembly: MenuAssembly
    private let tableViewExample = MainMenuItemViewModel(title: "Table View Cell Example")

    // MARK: MenuViewModel

    let title = "SwipeToReveal"

    var items: [MenuItemViewModel] {
        return [tableViewExample]
    }

    // MARK: MenuItemViewModelDelegate

    func menuItemViewModelDidSelect(_ viewModel: MenuItemViewModel) {
        if viewModel === tableViewExample {
            let viewController = assembly.tableViewExampleController
            delegate?.menuViewModel(self, presentViewController: viewController)
        } else {
            fatalError()
        }
    }

}
