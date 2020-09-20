import UIKit

enum CollectionConfiguration {
    static let rows: Int = 20
    static let columns: Int = 50
}

class ButtonCell: UICollectionViewCell {
    private func createLayout() {
        let button = UIButton(frame: bounds)
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button.backgroundColor = .blue
        contentView.addSubview(button)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createLayout()
    }
}

class CollectionExampleViewController: UIViewController {
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(320.0), heightDimension: .absolute(180.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    }
    
    override func loadView() {
        let view = UIView()
        self.view = view
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
    }
}

extension CollectionExampleViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CollectionConfiguration.rows
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionConfiguration.columns
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
}
