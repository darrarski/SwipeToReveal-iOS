import UIKit

extension Container {
    var menuAssembly: MenuAssembly {
        struct Assembly: MenuAssembly {}
        return Assembly()
    }
}
