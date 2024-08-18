import UIKit

final class NewTrackerCollectionViewCell: UICollectionViewCell {
    
    lazy var emojiLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 32)
        return element
    }()
    
    lazy var colorImage: UIImageView = {
        let element = UIImageView()
        element.layer.cornerRadius = 8
        return element
    }()
    
    override var isSelected: Bool {
        didSet {
            if !isSelected {
                backgroundColor = .none
                layer.borderWidth = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureEmojiCell(emoji: String) {
        emojiLabel.text = emoji
    }
    
    func configureColorCell(color: UIColor) {
        colorImage.backgroundColor = color
    }
    
    private func setupViews() {
        addSubview(emojiLabel)
        addSubview(colorImage)
    }
    
    private func addConstraints() {
        emojiLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        colorImage.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(5)
        }
    }
}
