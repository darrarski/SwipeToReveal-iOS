import UIKit

class MenuViewController: UITableViewController, MenuViewModelDelegate {

    init(assembly: MenuAssembly) {
        self.assembly = assembly
        viewModel = assembly.viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.title
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: .zero)
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else { return 0 }
        return viewModel.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 0 else { fatalError() }
        let viewModel = self.viewModel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = viewModel.title
        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { fatalError() }
        let viewModel = self.viewModel.items[indexPath.row]
        viewModel.select()
    }

    // MARK: MenuViewModelDelegate

    func menuViewModel(_ viewModel: MenuViewModel, presentViewController viewController: UIViewController) {
        guard viewModel === self.viewModel else { fatalError() }
        navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: Private

    private let assembly: MenuAssembly
    private let viewModel: MenuViewModel

}
