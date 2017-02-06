import UIKit
import SnapKit

class SwipeToRevealView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var contentView: UIView? {
        didSet {
            if let oldValue = oldValue {
                oldValue.removeFromSuperview()
            }
            if let newValue = contentView {
                addSubview(newValue)
                newValue.snp.makeConstraints { $0.edges.equalTo(0) }
            }
        }
    }

}
