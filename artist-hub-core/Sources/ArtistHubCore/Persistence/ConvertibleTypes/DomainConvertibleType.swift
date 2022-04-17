public protocol DomainConvertibleType {
    associatedtype Domain

    func domain() -> Domain
}

extension Array where Element: DomainConvertibleType {

    func domain() -> [Element.Domain] {
        map { $0.domain() }
    }
}
