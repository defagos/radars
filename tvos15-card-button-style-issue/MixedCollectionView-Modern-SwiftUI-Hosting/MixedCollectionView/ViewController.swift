import SwiftUI
import UIKit

final class ViewController: UICollectionViewController {
    private enum Section {
        case section1
        case section2
        case section3
        case section4
        case section5
        case section6
        case section7
        case section8
        case section9
        case section10
    }
    
    private struct Item: Hashable {
        let section: Section
        let item: Int
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    init() {
        super.init(collectionViewLayout: Self.layout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Item> { cell, _, item in
            cell.contentConfiguration = UIHostingConfiguration {
                Cell()
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        reloadData()
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.section1, .section2, .section3, .section4, .section5, .section6, .section7, .section8, .section9, .section10])
        snapshot.appendItems(Array(0...10).map { Item(section: .section1, item: $0) } , toSection: .section1)
        snapshot.appendItems(Array(0...30).map { Item(section: .section2, item: $0) } , toSection: .section2)
        snapshot.appendItems(Array(0...20).map { Item(section: .section3, item: $0) } , toSection: .section3)
        snapshot.appendItems(Array(0...50).map { Item(section: .section4, item: $0) } , toSection: .section4)
        snapshot.appendItems(Array(0...20).map { Item(section: .section5, item: $0) } , toSection: .section5)
        snapshot.appendItems(Array(0...10).map { Item(section: .section6, item: $0) } , toSection: .section6)
        snapshot.appendItems(Array(0...10).map { Item(section: .section7, item: $0) } , toSection: .section7)
        snapshot.appendItems(Array(0...10).map { Item(section: .section8, item: $0) } , toSection: .section8)
        snapshot.appendItems(Array(0...10).map { Item(section: .section9, item: $0) } , toSection: .section9)
        snapshot.appendItems(Array(0...10).map { Item(section: .section10, item: $0) } , toSection: .section10)
        dataSource.apply(snapshot)
    }
    
    private static func layoutConfiguration() -> UICollectionViewCompositionalLayoutConfiguration {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 60
        return configuration
    }
    
    private static func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { index, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(CGFloat(index + 1) * 50.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 60
            return section
        }, configuration: layoutConfiguration())
    }
}

private extension ViewController {
    struct Cell: View {
        var body: some View {
            GeometryReader { geometry in
                Button(action: {}) {
                    Color.green
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .buttonStyle(.card)
            }
        }
    }
}
