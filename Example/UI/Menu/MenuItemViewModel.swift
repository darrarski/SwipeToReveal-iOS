protocol MenuItemViewModel: class {
    weak var delegate: MenuItemViewModelDelegate? { get set }
    var title: String { get }
    func select()
}

protocol MenuItemViewModelDelegate: class {
    func menuItemViewModelDidSelect(_ viewModel: MenuItemViewModel)
}
