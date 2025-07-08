# Data Layer

This category is responsible for all data handling and business logic that is independent of the UI. It acts as an intermediary between the application and data sources.

It includes:
- **Models**: Plain Dart objects that represent the data structure (e.g., `UrlAliasResponse`).
- **Repositories**: Abstract classes defining a contract for data operations and their concrete implementations (e.g., `UrlShortenerRepository`).
- **Network**: The networking client (`DioClient`) and helper classes (`ApiResult`) responsible for communicating with the remote API.