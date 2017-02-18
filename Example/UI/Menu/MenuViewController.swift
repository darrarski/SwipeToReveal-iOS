import UIKit

class MenuViewController: UIViewController {

    init(assembly: MenuAssembly) {
        self.assembly = assembly
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

    // MARK: Private

    private let assembly: MenuAssembly

}
