import CoreData
import Foundation

extension Artist: EntityConvertibleType {

    // MARK: - EntityConvertibleType

    public func update(_ entity: ArtistEntity) {
        entity.artistId = Int16(id)
        entity.isFavorite = isFavorite
    }

    public func fetchRequest() -> NSFetchRequest<ArtistEntity> {
        let request = NSFetchRequest<ArtistEntity>(entityName: "ArtistEntity")
        request.predicate = NSPredicate(format: "artistId == \(id)")
        request.sortDescriptors = [NSSortDescriptor(key: "artistId", ascending: true)]
        return request
    }

    static func allStoredFetchRequest() -> NSFetchRequest<ArtistEntity> {
        let request = NSFetchRequest<ArtistEntity>(entityName: "ArtistEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "artistId", ascending: true)]
        return request
    }
}
