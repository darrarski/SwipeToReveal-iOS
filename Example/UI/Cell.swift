import UIKit
import SnapKit

class Cell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadSubviews()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Subviews

    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        label.textColor = .darkText
        return label
    }()

    private func loadSubviews() {
        contentView.addSubview(label)
    }

    // MARK: Layout

    private func setupLayout() {
        label.snp.makeConstraints {
            $0.centerYWithinMargins.equalTo(0)
            $0.topMargin.greaterThanOrEqualTo(0)
            $0.leftMargin.equalTo(0)
            $0.rightMargin.lessThanOrEqualTo(0)
            $0.bottomMargin.lessThanOrEqualTo(0)
        }
    }

}
