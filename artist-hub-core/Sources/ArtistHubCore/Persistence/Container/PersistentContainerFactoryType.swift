import CoreData

protocol PersistentContainerFactoryType {
    func makePersistentContainer() -> NSPersistentContainer?
}
