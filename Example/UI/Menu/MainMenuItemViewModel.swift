class MainMenuItemViewModel: MenuItemViewModel {

    init(title: String) {
        self.title = title
    }

    // MARK: MenuItemViewModel

    weak var delegate: MenuItemViewModelDelegate?

    let title: String

    func select() {
        delegate?.menuItemViewModelDidSelect(self)
    }

}
