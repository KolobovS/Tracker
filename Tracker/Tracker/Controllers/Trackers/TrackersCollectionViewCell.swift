import UIKit

final class TrackersCollectionViewCell: UICollectionViewCell {
    
    private lazy var cellView: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 16
        return element
    }()
    
    private lazy var cellLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 12, weight: .medium)
        element.textColor = .white
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var emojiImageView: UIImageView = {
        let element = UIImageView()
        element.layer.cornerRadius = 12
        element.backgroundColor = .white
        element.layer.opacity = 0.3
        return element
    }()
    
    private lazy var emojiLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 14, weight: .medium)
        return element
    }()
    
    private lazy var dateLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 12, weight: .medium)
        element.textColor = .ypBlack
        return element
    }()
    
    private lazy var doneButton: UIButton = {
        let element = UIButton()
        element.layer.cornerRadius = 17
        element.titleLabel?.font = .systemFont(ofSize: 20)
        element.titleLabel?.textAlignment = .center
        return element
    }()
    
    lazy var pinnedImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "pin.fill")
        element.tintColor = .white
        return element
    }()
    
    weak var delegate: TrackerCollectionViewCellDelegate?
    
    var isCompleted: Bool = false
    private var trackerID: UUID?
    private let dataProvider = DataProvider.shared
    private var pinUnpinTrackerLabel: String?
    var indexPath: IndexPath?
    var trackerInfo: Tracker?
    var completedDays: Int?
    
    var isTrackerPined: Bool? {
        didSet {
            guard let isTrackerPined = isTrackerPined else { return }
            
            switch isTrackerPined {
            case true:
                pinUnpinTrackerLabel = LocalizableConstants.ContextMenu.unpinButton
            case false:
                pinUnpinTrackerLabel = LocalizableConstants.ContextMenu.pinButton
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        addConstraints()
        setupTarget()
        addContextMenuInteraction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(tracker: Tracker, isCompleted: Bool, completedDays: Int, indexPath: IndexPath) {
        cellView.backgroundColor = tracker.color
        cellLabel.text = tracker.name
        doneButton.backgroundColor = tracker.color
        emojiLabel.text = tracker.emoji
        dateLabel.text = LocalizableConstants.TrackersVC.formatDaysString(completedDays)
        self.isCompleted = isCompleted
        self.trackerID = tracker.id
        self.indexPath = indexPath
        self.trackerInfo = tracker
        self.completedDays = completedDays
        
        let doneButtonTitle = isCompleted ? "✓" : "+"
        
        doneButton.setTitle(doneButtonTitle, for: .normal)
        doneButton.alpha = isCompleted ? 0.5 : 1
    }
    
    func lockDoneButton() {
        doneButton.isEnabled = false
        doneButton.setTitle("x", for: .normal)
        doneButton.titleLabel?.font = .systemFont(ofSize: 20)
        doneButton.titleLabel?.textAlignment = .center
        doneButton.alpha = 0.5
    }
    
    func unlockDoneButton() {
        doneButton.isEnabled = true
    }
    
    private func setupTarget() {
        doneButton.addTarget(self, action: #selector(doneTracker), for: .touchUpInside)
    }
    
    @objc private func doneTracker() {
        guard let trackerID = trackerID,
              let indexPath = indexPath else { return }
        if isCompleted {
            delegate?.uncompleteTracker(id: trackerID, at: indexPath)
        } else {
            delegate?.completeTracker(id: trackerID, at: indexPath)
        }
    }
    
    func pinTracker(cell: TrackersCollectionViewCell) {
        delegate?.pinTracker(cell)
    }
    
    func unpinTracker(cell: TrackersCollectionViewCell) {
        delegate?.unpinTracker(cell)
    }
    
    func editTracker(cell: TrackersCollectionViewCell) {
        delegate?.editTracker(cell)
    }
    
    func deleteTracker(cell: TrackersCollectionViewCell) {
        delegate?.deleteTracker(cell)
    }
    
    private func setupViews() {
        addSubview(cellView)
        addSubview(dateLabel)
        addSubview(doneButton)
        cellView.addSubview(emojiImageView)
        cellView.addSubview(emojiLabel)
        cellView.addSubview(pinnedImage)
        cellView.addSubview(cellLabel)
    }
    
    private func addConstraints() {
        cellView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(90)
        }
        
        emojiImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.width.height.equalTo(24)
        }
        
        emojiLabel.snp.makeConstraints { make in
            make.center.equalTo(emojiImageView)
        }
        
        pinnedImage.snp.makeConstraints { make in
            make.width.height.equalTo(14)
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(emojiImageView)
        }
        
        cellLabel.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(34)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(doneButton)
            make.leading.equalToSuperview().offset(12)
            make.width.equalTo(101)
        }
        
        doneButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.width.height.equalTo(34)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

extension TrackersCollectionViewCell: UIContextMenuInteractionDelegate {
    func addContextMenuInteraction() {
        let interaction = UIContextMenuInteraction(delegate: self)
        cellView.addInteraction(interaction)
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        guard let isTrackerPined = isTrackerPined else { return UIContextMenuConfiguration() }

        let pinImage = isTrackerPined ? UIImage(systemName: "pin.slash") : UIImage(systemName: "pin")
        let editImage = UIImage(systemName: "square.and.pencil")
        let deleteImage = UIImage(systemName: "trash")
        
        return UIContextMenuConfiguration(actionProvider: { actions in
            return UIMenu(children: [
                UIAction(title: self.pinUnpinTrackerLabel ?? "",
                         image: pinImage) { [weak self] _ in
                    guard let self = self else { return }
                    isTrackerPined ? self.unpinTracker(cell: self) : self.pinTracker(cell: self)
                },
                UIAction(title: LocalizableConstants.ContextMenu.editButton,
                         image: editImage) { [weak self] _ in
                    guard let self = self else { return }
                    self.editTracker(cell: self)
                },
                UIAction(title: LocalizableConstants.ContextMenu.deleteButton,
                         image: deleteImage,
                         attributes: .destructive) { [weak self] _ in
                    guard let self = self else { return }
                    self.deleteTracker(cell: self)
                }
            ])
        })
    }
}
