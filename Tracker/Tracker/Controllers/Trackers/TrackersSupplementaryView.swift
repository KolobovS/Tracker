import UIKit

final class TrackersSupplementaryView: UICollectionReusableView {
    
    lazy var headerLabel: UILabel = {
        let element = UILabel()
        element.font = .boldSystemFont(ofSize: 19)
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(headerLabel)
    }
    
    private func addConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(28)
        }
    }
}
