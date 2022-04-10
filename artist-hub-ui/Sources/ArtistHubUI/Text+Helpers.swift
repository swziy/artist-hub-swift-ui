import SwiftUI

extension Text {

    public func resizableOneLine() -> some View {
        self.scaledToFit()
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            .fixedSize(horizontal: false, vertical: true)
    }
}
