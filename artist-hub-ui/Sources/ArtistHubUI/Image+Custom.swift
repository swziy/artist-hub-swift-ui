import SwiftUI

extension Image {

    public enum Icons {

        public static var placeholder: Image {
            Image("placeholder", bundle: .module)
        }

        public static var heartOutline: Image {
            Image("heart_outline", bundle: .module)
        }

        public static var heartFilled: Image {
            Image("heart_filled", bundle: .module)
        }

        public static var error: Image {
            Image("error", bundle: .module)
        }
    }
}
