import UIKit
import Reusable

class TableExampleViewController: UITableViewController {

    init(assembly: TableExampleAssembly) {
        self.assembly = assembly
        super.init(style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: TableExampleCell.self)
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 100
        default: fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableExampleCell = tableView.dequeueReusableCell(for: indexPath)
        cell.label.text = "Cell \(indexPath.row + 1)"
        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0, _):
            return 88
        default:
            fatalError()
        }
    }

    // MARK: Private

    private let assembly: TableExampleAssembly

}
