# Core

This category contains shared code and utilities that can be used across multiple features in the application. The goal is to avoid code duplication and maintain a consistent design.

It is typically divided into:
- **Theme**: App-wide theming, including colors (`AppColors`), text styles (`AppTextStyles`), sizes (`AppSizes`), and spacing (`AppSpacing`).
- **Widgets**: Common, reusable widgets that are not specific to any single feature (e.g., `UrlListItem`).
- **Assets**: Constants for asset paths, such as SVGs or images (`AppSvgs`).
- **Utils**: General-purpose utility functions and extensions.