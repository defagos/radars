import UIKit

final class BrowserViewController: UITableViewController {
    private static let cellIdentifier = "cell"
    
    private static let titles: [String] = {
        return (0...100).map { "Cell \($0)" }
    }()
    
    private var titles = BrowserViewController.titles
    
    static func browserViewController() -> UIViewController {
#if os(tvOS)
        let browserViewController = BrowserViewController()
        let searchController = UISearchController(searchResultsController: browserViewController)
        searchController.searchResultsUpdater = browserViewController
        return UISearchContainerViewController(searchController: searchController)
#else
        return BrowserViewController()
#endif
    }
    
    override var title: String? {
        get {
            return "Browser"
        }
        set {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        
#if os(iOS)
        let searchController = UISearchController(searchResultsController: nil)
        searchController.showsSearchResultsController = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
#endif
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = titles[indexPath.row]
        cell.contentConfiguration = configuration
    }
}

extension BrowserViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            titles = Self.titles.filter { $0.contains(text) }
        }
        else {
            titles = Self.titles
        }
        tableView.reloadData()
    }
}
