# Flutter Riverpod Starter Template

A production-ready Flutter starter template built with [Riverpod](https://riverpod.dev/) state management and [GoRouter](https://pub.dev/packages/go_router) for navigation. This template provides a solid foundation for building scalable, maintainable Flutter applications with robust architecture.

## Features

- **Riverpod State Management** with code generation and providers
- **GoRouter Navigation** with redirection logic and nested routes
- **Multi-flavor Support** (development, staging, production)
- **Authentication Flow** with login, logout, and token handling
- **Onboarding Support** with persistent state
- **Localization** using Easy Localization
- **Robust Error Handling** with graceful degradation
- **Network Layer** with Dio, interceptors, and result types
- **Dual Cache Strategy** with persistent (Hive) and memory caching
- **Clean Architecture** with presentation, application, domain, and data layers
- **Theme Management** with light and dark mode support
- **Logger** with custom Riverpod observer for debugging

## Getting Started

### Prerequisites

- Flutter 3.7.0 or higher
- Dart 3.0.0 or higher

### Installation

1. Clone this repository:
```bash
git clone https://github.com/TheinvinciblePrints/riverpod_starter_template.git
cd flutter_riverpod_starter_template
```

2. Install dependencies:
```bash
flutter pub get
```

3. **Set up environment files** (Required):

   **Quick Setup (Recommended):**
   ```bash
   # Run the automated setup script
   ./setup.sh
   ```
   This will create all environment files and install dependencies automatically.

   **Manual Setup:**
   Create three environment files in the root directory. You can use the provided template:

   ```bash
   # Copy the template to create your environment files
   cp .env.template .env.dev
   cp .env.template .env.staging  
   cp .env.template .env.prod
   ```

   Then edit each file and replace `your_news_api_key_here` with your actual API key:

   **`.env.dev`** (Development environment):
   ```env
   DUMMY_JSON_API_URL=https://dummyjson.com
   NEWS_API_URL=https://newsapi.org/v2
   API_KEY=your_news_api_key_here
   ```

   **`.env.staging`** (Staging environment):
   ```env
   DUMMY_JSON_API_URL=https://dummyjson.com
   NEWS_API_URL=https://newsapi.org/v2
   API_KEY=your_news_api_key_here
   ```

   **`.env.prod`** (Production environment):
   ```env
   DUMMY_JSON_API_URL=https://dummyjson.com
   NEWS_API_URL=https://newsapi.org/v2
   API_KEY=your_news_api_key_here
   ```

   **Getting API Keys:**
   - **News API Key**: Get your free API key from [newsapi.org](https://newsapi.org/register)
   - **Test Login Credentials**: For testing authentication, you can use:
     - Username: `emilys`
     - Password: `emilyspassword`
     - Or get test users from: [https://dummyjson.com/users](https://dummyjson.com/users)

4. Run code generation for Riverpod, JSON serialization, and more:
```bash
dart run build_runner build --delete-conflicting-outputs
```

5. Run the app in your preferred flavor:
```bash
# Development flavor
flutter run --flavor dev -t lib/main.dart

# Staging flavor
flutter run --flavor staging -t lib/main.dart

# Production flavor
flutter run --flavor prod -t lib/main.dart
```

## Project Structure

```
lib/
├── flavors.dart               # Flavor configuration
├── main.dart                  # App entry point
└── src/
    ├── app.dart               # App widget
    ├── config/                # App configuration
    ├── features/              # Feature modules
    │   ├── authentication/    # Auth feature
    │   │   ├── application/   # Auth business logic
    │   │   ├── data/          # Auth repositories
    │   │   ├── domain/        # Auth models
    │   │   └── presentation/  # Auth UI
    │   ├── countries/         # Countries feature with persistent cache
    │   │   ├── application/   # Countries service
    │   │   ├── data/          # Countries repository
    │   │   ├── domain/        # Country models
    │   │   └── presentation/  # Countries demo UI
    │   ├── home/              # Home feature
    │   └── onboarding/        # Onboarding feature
    ├── localization/          # Translations
    ├── network/               # Network layer
    ├── providers/             # Global providers
    ├── routing/               # Router configuration
    ├── storage/               # Local storage
    └── theme/                 # App theme
```

## Architecture

This template follows a layered architecture pattern inspired by Domain-Driven Design and Clean Architecture:

1. **Presentation Layer** (UI): Widgets, Screens, Controllers
2. **Application Layer** (Use Cases): Services coordinating business logic
3. **Domain Layer** (Business Logic): Entities, Value Objects
4. **Data Layer** (Infrastructure): Repositories, Data Sources

See the [ARCHITECTURE.md](./ARCHITECTURE.md) file for more detailed information.

## Key Concepts

### Riverpod Usage

This template uses Riverpod with code generation for efficient state management:

```dart
// Creating a provider with code generation
@riverpod
class Authentication extends _$Authentication {
  @override
  AuthenticationState build() {
    // Initial state setup
    return const AuthenticationState.initial();
  }
  
  // Methods to modify state
  void setUsername(String username) {
    // Update state here
  }
}

// Using the provider
final authState = ref.watch(authenticationProvider);
```

### Caching Strategy

This template implements a dual caching strategy for optimal performance:

**Memory Cache (MemCacheStore)**:
- Used for dynamic data like news articles
- Fast access during app session
- Automatically cleared on app restart

**Persistent Cache (HiveCacheStore)**:
- Used for static data like countries and news sources
- Survives app restarts
- Powered by Hive for efficient storage

```dart
// Using persistent cache for countries
final countriesService = await ref.read(countriesServiceProvider.future);
final countries = await countriesService.getCountries(); // From cache if available

// Force refresh from network
final freshCountries = await countriesService.getCountriesFresh();
```

See [PERSISTENT_CACHE_IMPLEMENTATION.md](./PERSISTENT_CACHE_IMPLEMENTATION.md) for detailed implementation guide.

### Navigation

Navigation is handled with GoRouter, with redirection based on app state:

```dart
// Navigate to a route
context.go(AppRoute.home.path);

// Navigate with parameters
context.goNamed(
  AppRoute.details.name, 
  pathParameters: {'id': item.id},
);
```

### Working with Flavors

Customize each flavor by modifying `flavorizr.yaml` and regenerate with:

```bash
flutter pub run flutter_flavorizr
```

## Customization

### Adding a New Feature

1. Create feature directory structure:
   ```
   lib/src/features/your_feature/
   ├── application/   # Services, use cases
   ├── data/          # Repositories, data sources
   ├── domain/        # Models, entities
   └── presentation/  # UI components
   ```

2. Add new routes in `lib/src/routing/app_router.dart`

3. Create necessary providers with Riverpod

### Changing Theme

Modify theme configurations in `lib/src/theme/` directory.

## Testing

The template is set up with a test structure that mirrors the application structure:

```bash
# Run all tests
flutter test

# Run specific tests
flutter test test/features/authentication/
```

## Troubleshooting

### Common Setup Issues

1. **Missing Environment Files**:
   ```
   Error: No such file or directory '.env.dev'
   ```
   Solution: Create the three environment files as described in step 3 of installation.

2. **Missing News API Key**:
   ```
   HTTP 401: Unauthorized
   ```
   Solution: Add your valid News API key to all three `.env` files.

3. **Code Generation Errors**:
   ```
   Error: Could not find part file
   ```
   Solution: Run the build runner command:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Hive Cache Initialization Issues**:
   ```
   Error: HiveError: Box not found
   ```
   Solution: The app will automatically initialize Hive. If issues persist, clear app data.

### API Endpoints Used

- **Authentication**: DummyJSON API (`https://dummyjson.com`)
- **News**: NewsAPI.org (`https://newsapi.org/v2`)
- **Countries**: REST Countries API (`https://restcountries.com/v3.1/all`)

The Countries API is free and doesn't require authentication.

## Best Practices and Tips

1. **Use Riverpod Code Generation**: Always use `@riverpod` annotations for providers
2. **Keep Providers Focused**: Each provider should have a single responsibility
3. **Handle Async Operations**: Use `AsyncValue` to handle loading, error and data states
4. **Error Handling**: Wrap network calls in proper error handling
5. **Data Validation**: Validate user inputs before submitting
6. **Dependency Injection**: Use Riverpod for dependency injection

## License

This project is licensed under the MIT License - see the LICENSE file for details.
