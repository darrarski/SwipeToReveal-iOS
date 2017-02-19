import UIKit

protocol MenuViewModel: class {
    weak var delegate: MenuViewModelDelegate? { get set }
    var title: String { get }
    var items: [MenuItemViewModel] { get }
}

protocol MenuViewModelDelegate: class {
    func menuViewModel(_ viewModel: MenuViewModel, presentViewController viewController: UIViewController)
}
