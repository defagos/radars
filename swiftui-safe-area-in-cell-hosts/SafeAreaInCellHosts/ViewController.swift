import SwiftUI
import UIKit

struct NumberCell: View {
    let number: Int
    
    var body: some View {
        ZStack {
            Color.red
            Text("\(number)")
        }
    }
}

class HostCell<Content: View>: UICollectionViewCell {
    private var hostController: UIHostingController<Content>?
    
    var content: Content? {
        didSet {
            if let content = content {
                if let hostController = hostController {
                    hostController.rootView = content
                }
                else {
                    hostController = UIHostingController(rootView: content)
                }
                
                if let hostView = hostController?.view, hostView.superview != contentView {
                    hostView.frame = contentView.bounds
                    hostView.backgroundColor = .clear
                    hostView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    contentView.addSubview(hostView)
                }
            }
            else if let hostView = hostController?.view {
                hostView.removeFromSuperview()
            }
        }
    }
}

class ViewController: UICollectionViewController {
    private enum Section {
        case main
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    static func layout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group:  group)
            section.interGroupSpacing = 4
            return section
        }
    }
    
    init() {
        super.init(collectionViewLayout: Self.layout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellRegistration = UICollectionView.CellRegistration<HostCell<NumberCell>, Int> { cell, _, item in
            cell.content = NumberCell(number: item)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        loadData()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    private func loadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(1...100), toSection: .main)
        dataSource.apply(snapshot)
    }
}
