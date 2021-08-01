import UIKit

public protocol ReusableIdentifier: AnyObject {
    static var reusableIdentifier: String { get }
}

public extension ReusableIdentifier {
    static var reusableIdentifier: String { String(describing: Self.self) }
}

extension UITableViewCell: ReusableIdentifier { }

public extension UITableView {
    
    func register<T: ReusableIdentifier>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: type.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: ReusableIdentifier>(
        _ type: T.Type = T.self,
        for indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: type.reusableIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("Unexpected cell type \(type)")
        }
        return cell
    }
}
