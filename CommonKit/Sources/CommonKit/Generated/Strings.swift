// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum localization {
  public enum Screen {
    public enum About {
      /// About
      public static let title = localization.tr("Localizable", "screen.about.title", fallback: "About")
      public enum Contactme {
        public enum Button {
          /// Contact Me
          public static let title = localization.tr("Localizable", "screen.about.contactme.button.title", fallback: "Contact Me")
        }
      }
      public enum Personalwebsite {
        public enum Button {
          /// Personal Website
          public static let title = localization.tr("Localizable", "screen.about.personalwebsite.button.title", fallback: "Personal Website")
        }
      }
    }
    public enum Detailmovie {
      public enum Button {
        /// Visit Official Website
        public static let title = localization.tr("Localizable", "screen.detailmovie.button.title", fallback: "Visit Official Website")
      }
      public enum Companies {
        /// Production Companies
        public static let subtitle = localization.tr("Localizable", "screen.detailmovie.companies.subtitle", fallback: "Production Companies")
      }
      public enum Overview {
        /// Overview
        public static let subtitle = localization.tr("Localizable", "screen.detailmovie.overview.subtitle", fallback: "Overview")
      }
      public enum Tab {
        public enum Info {
          /// Review
          public static let review = localization.tr("Localizable", "screen.detailmovie.tab.info.review", fallback: "Review")
          /// Info
          public static let title = localization.tr("Localizable", "screen.detailmovie.tab.info.title", fallback: "Info")
        }
      }
    }
    public enum Favorites {
      /// Favorites
      public static let title = localization.tr("Localizable", "screen.favorites.title", fallback: "Favorites")
    }
    public enum Home {
      /// Localizable.strings
      ///   CommonKit
      /// 
      ///   Created by Achmad Rijalu on 16/11/25.
      public static let subtitle = localization.tr("Localizable", "screen.home.subtitle", fallback: "Now Playing")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = Bundle.module.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
