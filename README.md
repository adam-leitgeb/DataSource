# DataSource

Wrapper around UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource and UICollectionViewDelegate. Havily inspired by Futured's CellKit: https://github.com/futuredapp/CellKit

## Support

- [x] UITableView & UICollectionView
- [x] Selecting cells
- [x] Actions (swipe to delete, ...)
- [x] Lazy loading (pagination)
- [x] Headers / Footers


## Example

### Cell
````
final class TextCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
}

extension TextCell: CellConfigurable {
    func configure(with model: TextCellModel) {
        titleLabel.text = model.title
    }
}
````
### CellModel 
````
struct TextCellModel {
    let title: String
}

extension TextCellModel: CellModelConvertible {
    typealias Cell = PriceDetailCell

    var height: CGFloat {
        UITableView.automaticDimension
    }
}
````
### ViewController
````
final class HomeViewController: UITableViewController {

    // MARK: - Properties

    private var userNetworkingWorker = UserNetworkingWorker()
    private var dataSource = DataSource()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
        tableView.delegate = dataSource

        userNetworkingWorker.loadData() { users in
            let cells = users.map { TextCellModel(title: $0.name) }
            let section = Section(cells: cells)

            self.dataSource.sections = [section]
            self.tableView.reloadData()
        }
    }
}
````
