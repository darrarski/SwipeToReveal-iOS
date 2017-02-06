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

    let swipeToReveal = SwipeToRevealView(frame: .zero)

    private func loadSubviews() {
        contentView.addSubview(swipeToReveal)
        swipeToReveal.contentView = swipeContentView
        swipeContentView.addSubview(label)
    }

    private let swipeContentView: UIView = {
        let view = UIView(frame: .zero)
        view.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return view
    }()

    // MARK: Layout

    private func setupLayout() {
        swipeToReveal.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
        label.snp.makeConstraints {
            guard let superview = label.superview else { fatalError() }
            $0.centerYWithinMargins.equalTo(0)
            $0.top.greaterThanOrEqualTo(superview.snp.topMargin)
            $0.left.equalTo(superview.snp.leftMargin)
            $0.right.lessThanOrEqualTo(superview.snp.rightMargin)
            $0.bottom.lessThanOrEqualTo(superview.snp.bottomMargin)
        }
    }

}
