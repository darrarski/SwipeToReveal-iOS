import UIKit

extension Container {
    var tableViewExampleAssembly: TableViewExampleAssembly {
        struct Assembly: TableViewExampleAssembly {}
        return Assembly()
    }
}
