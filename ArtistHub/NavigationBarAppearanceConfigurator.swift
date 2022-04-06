import UIKit
import SwiftUI
import ArtistHubUI

public protocol NavigationBarAppearanceConfiguratorType {
    func configure()
}


public struct NavigationBarAppearanceConfigurator: NavigationBarAppearanceConfiguratorType {

    // MARK: - Initialization

    public init() {}

    // MARK: - NavigationBarAppearanceConfiguratorType

    public func configure() {
        UINavigationBar.appearance().standardAppearance = appearanceForStandardNavigationBar()
        UINavigationBar.appearance().scrollEdgeAppearance = appearanceForLargeNavigationBar()
    }

    // MARK: - Private

    private func appearanceForStandardNavigationBar() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(Color.Fill.accent)
        titleAttributes(for: appearance)

        return appearance
    }

    private func appearanceForLargeNavigationBar() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Color.Fill.lightGray)
        titleAttributes(for: appearance)

        return appearance
    }

    private func titleAttributes(for appearance: UINavigationBarAppearance) {
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemPink]
    }
}
