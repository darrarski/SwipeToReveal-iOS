import UIKit

extension Container {
    var tableViewAssembly: TableViewAssembly {
        struct Assembly: TableViewAssembly {}
        return Assembly()
    }
}
