import UIKit

extension Container {
    var tableExampleAssembly: TableExampleAssembly {
        struct Assembly: TableExampleAssembly {}
        return Assembly()
    }
}
