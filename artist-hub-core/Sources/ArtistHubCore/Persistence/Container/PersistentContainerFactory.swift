import CoreData

struct PersistentContainerFactory: PersistentContainerFactoryType {

    private static var container: NSPersistentContainer?

    // MARK: - PersistentContainerFactoryType

    func makePersistentContainer() -> NSPersistentContainer? {
        if let container = PersistentContainerFactory.container {
            return container
        }

        guard let model = NSManagedObjectModel.mergedModel(from: [.module]) else {
            return nil
        }

        let container = NSPersistentContainer(name: "MainDataModel", managedObjectModel: model)

        var loadError: Error?
        container.loadPersistentStores { description, error in
            loadError = error
        }

        if loadError != nil {
            return nil
        }

        PersistentContainerFactory.container = container

        return container
    }
}
