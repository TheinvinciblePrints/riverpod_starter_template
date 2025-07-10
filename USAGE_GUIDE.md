# Flutter Riverpod Starter Template: Usage Guide

This guide provides detailed examples and best practices for using this Flutter Riverpod Starter Template.

## Table of Contents

1. [Authentication Flow](#authentication-flow)
2. [Routing](#routing)
3. [State Management](#state-management)
4. [Adding Features](#adding-features)
5. [Working with Network Requests](#working-with-network-requests)
6. [Error Handling](#error-handling)
7. [Code Generation](#code-generation)
8. [Localization](#localization)
9. [Asset Management](#asset-management)
10. [Local Storage](#local-storage)
11. [Flavors and Environment Configuration](#flavors-and-environment-configuration)
12. [Testing](#testing)

## Authentication Flow

The authentication flow in this template follows these steps:

1. App startup → check for existing authentication token
2. If token exists and is valid → go to Home
3. If token doesn't exist or is invalid → go to Login
4. After login success → store token and go to Home

### Authentication Example

```dart
// In your screen
final authState = ref.watch(authenticationProvider);

return switch (authState) {
  AuthenticationInitial() => const SplashScreen(),
  AuthenticationLoading() => const LoadingIndicator(),
  AuthenticationAuthenticated(user: final user) => Text('Welcome ${user.username}'),
  AuthenticationUnauthenticated(error: final error) => 
      LoginForm(error: error),
};

// Trigger login
void _handleLogin() {
  ref.read(authenticationProvider.notifier).login();
}

// Logging out
void _handleLogout() {
  ref.read(authenticationProvider.notifier).logout();
}
```

## Routing

The app uses GoRouter for navigation with a declarative routing system.

### Route Definition

Routes are defined in `lib/src/routing/app_router.dart`:

```dart
// Define routes
enum AppRoute { splash, onboarding, login, home, details }

// Route paths with parameters
extension AppRouteExtension on AppRoute {
  String get path {
    return switch (this) {
      AppRoute.splash => '/splash',
      AppRoute.onboarding => '/onboarding',
      AppRoute.login => '/login',
      AppRoute.home => '/home',
      AppRoute.details => '/details/:id',
    };
  }
  
  String get name => this.toString().split('.').last;
}
```

### Navigation Examples

```dart
// Basic navigation
context.go(AppRoute.home.path);

// Navigate with parameters
context.goNamed(
  AppRoute.details.name,
  pathParameters: {'id': '123'},
);

// Navigate with query parameters
context.go(
  '${AppRoute.search.path}?query=flutter&filter=recent',
);

// Pass extra data (not visible in URL)
context.go(
  AppRoute.login.path,
  extra: {'message': 'Session expired'},
);
```

## State Management

The template uses Riverpod with code generation for state management.

### Provider Types

1. **State Notifier Providers**: For complex state with multiple operations
2. **Future Providers**: For async data fetching
3. **Regular Providers**: For simple derived state

### Creating a Provider

```dart
// Simple provider with code generation
@riverpod
String greeting(GreetingRef ref) {
  return 'Hello, World!';
}

// Class-based provider with code generation
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;
  
  void increment() => state++;
  void decrement() => state--;
}

// Provider with parameters
@riverpod
Future<List<Product>> products(
  ProductsRef ref, 
  {required String category}
) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProductsByCategory(category);
}
```

### Using Providers

```dart
// Reading a provider
final greeting = ref.watch(greetingProvider);
final counter = ref.watch(counterProvider);

// Reading a parameterized provider
final products = ref.watch(
  productsProvider(category: 'electronics'),
);

// Accessing notifier
final counterNotifier = ref.read(counterProvider.notifier);
counterNotifier.increment();
```

## Adding Features

To add a new feature to the application:

### 1. Create Feature Structure

```
lib/src/features/your_feature/
├── application/
│   └── your_service.dart
├── data/
│   └── your_repository.dart
├── domain/
│   └── your_model.dart
└── presentation/
    ├── your_screen.dart
    ├── your_controller.dart
    └── widgets/
        └── your_widget.dart
```

### 2. Add Models

```dart
// In domain/product_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required double price,
    String? description,
    @Default(0) int stockQuantity,
  }) = _Product;
  
  factory Product.fromJson(Map<String, dynamic> json) => 
      _$ProductFromJson(json);
}
```

### 3. Create Repository

```dart
// In data/product_repository.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../network/api_client.dart';
import '../domain/product_model.dart';

part 'product_repository.g.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductById(String id);
}

class ProductRepositoryImpl implements ProductRepository {
  final ApiClient _apiClient;
  
  ProductRepositoryImpl(this._apiClient);
  
  @override
  Future<List<Product>> getProducts() async {
    final response = await _apiClient.get('/products');
    return (response.data as List)
        .map((json) => Product.fromJson(json))
        .toList();
  }
  
  @override
  Future<Product> getProductById(String id) async {
    final response = await _apiClient.get('/products/$id');
    return Product.fromJson(response.data);
  }
}

@riverpod
ProductRepository productRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProductRepositoryImpl(apiClient);
}
```

### 4. Create Service

```dart
// In application/product_service.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/product_repository.dart';
import '../domain/product_model.dart';

part 'product_service.g.dart';

class ProductService {
  final ProductRepository _repository;
  
  ProductService(this._repository);
  
  Future<List<Product>> getProducts() => _repository.getProducts();
  
  Future<Product> getProductById(String id) => 
      _repository.getProductById(id);
      
  Future<List<Product>> searchProducts(String query) async {
    final products = await _repository.getProducts();
    return products.where(
      (product) => product.name.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}

@riverpod
ProductService productService(Ref ref) {
  final repository = ref.watch(productRepositoryProvider);
  return ProductService(repository);
}
```

### 5. Create Controllers/Providers

```dart
// In presentation/product_controller.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../application/product_service.dart';
import '../domain/product_model.dart';

part 'product_controller.g.dart';

@riverpod
class ProductsController extends _$ProductsController {
  @override
  Future<List<Product>> build() async {
    final service = ref.watch(productServiceProvider);
    return service.getProducts();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => 
      ref.read(productServiceProvider).getProducts());
  }
  
  Future<void> search(String query) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => 
      ref.read(productServiceProvider).searchProducts(query));
  }
}
```

### 6. Create Screens

```dart
// In presentation/products_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product_controller.dart';
import 'widgets/product_card.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsControllerProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: productsAsync.when(
        data: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => 
              ProductCard(product: products[index]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => 
            ref.read(productsControllerProvider.notifier).refresh(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
```

### 7. Add Route

```dart
// In app_router.dart
GoRoute(
  path: AppRoute.products.path,
  name: AppRoute.products.name,
  pageBuilder: (context, state) => 
      NoTransitionPage(child: ProductsScreen()),
),
```

## Working with Network Requests

The template includes a network layer with Dio for API calls.

### Making Network Requests

```dart
// Simple GET request
final response = await _apiClient.get('/users');

// POST request with body
final response = await _apiClient.post(
  '/users',
  data: {'name': 'John', 'email': 'john@example.com'},
);

// Handling responses with Result type
final result = await _apiClient.getResult<User>(
  '/users/123',
  fromJson: User.fromJson,
);

return switch (result) {
  Success(data: final user) => user,
  Error(error: final error) => throw error,
};
```

### Custom API Client

For specific features, you can create dedicated API clients:

```dart
@riverpod
ApiClient productApiClient(Ref ref) {
  final baseClient = ref.watch(apiClientProvider);
  return baseClient.withBaseUrl('https://api.example.com/products/v2');
}
```

## Error Handling

This template includes robust error handling patterns for network requests and other async operations.

### Error Types

The template defines specific error types for different scenarios:

```dart
// Base failure types
sealed class Failure {
  const Failure(this.message);
  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, this.errors);
  final Map<String, String> errors;
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
```

### Repository Error Handling

Use the Result type for robust error handling in repositories:

```dart
// Using Result type in repositories
class UserRepository {
  final ApiClient _apiClient;
  
  UserRepository(this._apiClient);
  
  Future<Result<User>> getUser(String id) async {
    try {
      final response = await _apiClient.get('/users/$id');
      return Success(User.fromJson(response.data));
    } on DioException catch (e) {
      return Error(_mapDioException(e));
    } catch (e) {
      return Error(UnknownFailure('Unexpected error: $e'));
    }
  }
  
  Failure _mapDioException(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout => 
        const NetworkFailure('Connection timeout'),
      DioExceptionType.connectionError => 
        const NetworkFailure('No internet connection'),
      DioExceptionType.badResponse => _handleBadResponse(e),
      _ => NetworkFailure('Network error: ${e.message}'),
    };
  }
  
  Failure _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    return switch (statusCode) {
      400 => ValidationFailure('Invalid request', 
             _parseValidationErrors(e.response?.data)),
      401 => const NetworkFailure('Unauthorized'),
      403 => const NetworkFailure('Access forbidden'),
      404 => const NetworkFailure('Resource not found'),
      500 => const NetworkFailure('Server error'),
      _ => NetworkFailure('HTTP $statusCode: ${e.message}'),
    };
  }
}
```

### Service Layer Error Handling

Services coordinate between repositories and handle business logic errors:

```dart
class UserService {
  final UserRepository _userRepository;
  
  UserService(this._userRepository);
  
  Future<Result<User>> getUserProfile(String id) async {
    // Validate input
    if (id.isEmpty) {
      return const Error(ValidationFailure('User ID is required', 
        {'id': 'User ID cannot be empty'}));
    }
    
    // Call repository
    final result = await _userRepository.getUser(id);
    
    return switch (result) {
      Success(data: final user) => _validateUser(user),
      Error(error: final error) => Error(error),
    };
  }
  
  Result<User> _validateUser(User user) {
    if (user.isBlocked) {
      return const Error(ValidationFailure('User is blocked', 
        {'user': 'This user account has been blocked'}));
    }
    return Success(user);
  }
}
```

### UI Error Handling

In the presentation layer, handle errors gracefully:

```dart
class UserProfileScreen extends ConsumerWidget {
  final String userId;
  
  const UserProfileScreen({required this.userId, super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider(userId));
    
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: userAsync.when(
        data: (result) => switch (result) {
          Success(data: final user) => UserProfileContent(user: user),
          Error(error: final error) => ErrorDisplayWidget(
            error: error,
            onRetry: () => ref.refresh(userProvider(userId)),
          ),
        },
        loading: () => const LoadingWidget(),
        error: (error, stack) => UnexpectedErrorWidget(
          error: error,
          onRetry: () => ref.refresh(userProvider(userId)),
        ),
      ),
    );
  }
}
```

### Error Display Widgets

Create reusable error display widgets:

```dart
class ErrorDisplayWidget extends StatelessWidget {
  final Failure error;
  final VoidCallback? onRetry;
  
  const ErrorDisplayWidget({
    required this.error,
    this.onRetry,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return switch (error) {
      NetworkFailure() => NetworkErrorWidget(
        message: error.message,
        onRetry: onRetry,
      ),
      ValidationFailure() => ValidationErrorWidget(
        message: error.message,
        errors: error.errors,
      ),
      UnknownFailure() => GenericErrorWidget(
        message: error.message,
        onRetry: onRetry,
      ),
    };
  }
}

class NetworkErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  
  const NetworkErrorWidget({
    required this.message,
    this.onRetry,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
```

### Provider Error Handling

Handle errors in Riverpod providers:

```dart
@riverpod
class UserController extends _$UserController {
  @override
  Future<Result<User>> build(String userId) async {
    final userService = ref.watch(userServiceProvider);
    return userService.getUserProfile(userId);
  }
  
  Future<void> refreshUser() async {
    state = const AsyncValue.loading();
    
    final userService = ref.read(userServiceProvider);
    final result = await userService.getUserProfile(userId);
    
    state = AsyncValue.data(result);
  }
  
  Future<void> updateUser(User updatedUser) async {
    // Show loading for the current user while updating
    final currentState = state.value;
    if (currentState is Success<User>) {
      state = AsyncValue.data(
        Success(updatedUser.copyWith(isLoading: true))
      );
    }
    
    final userService = ref.read(userServiceProvider);
    final result = await userService.updateUser(updatedUser);
    
    state = AsyncValue.data(result);
  }
}
```

### Global Error Handling

Set up global error handling for unhandled exceptions:

```dart
// In main.dart
void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    
    FlutterError.onError = (details) {
      // Log to crash reporting service
      FirebaseCrashlytics.instance.recordFlutterError(details);
    };
    
    runApp(const ProviderScope(child: MyApp()));
  }, (error, stack) {
    // Handle errors that occur outside of Flutter
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}

## Code Generation

This template heavily uses code generation for Riverpod providers, JSON serialization, and other boilerplate code.

### Understanding Code Generation

The template uses several code generation tools:

1. **build_runner**: Orchestrates all code generation
2. **riverpod_generator**: Generates provider code
3. **freezed**: Generates immutable classes with copy methods
4. **json_serializable**: Generates JSON serialization code
5. **flutter_gen**: Generates type-safe asset references

### Code Generation Commands

```bash
# Run all code generation (most common)
dart run build_runner build --delete-conflicting-outputs

# Watch for changes and regenerate automatically (during development)
dart run build_runner watch --delete-conflicting-outputs

# Clean generated files (when having issues)
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs

# Generate only specific files
dart run build_runner build --build-filter="lib/src/features/**"
```

### Code Generation Best Practices

**1. Always run code generation after:**
- Adding/modifying `@riverpod` providers
- Adding/modifying `@freezed` classes
- Adding/modifying `@JsonSerializable` classes
- Adding new assets to the project

**2. Use proper annotations:**

```dart
// Riverpod provider with code generation
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  User? build() => null;
  
  void setUser(User user) => state = user;
}

// Freezed model with JSON serialization
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    @Default('') String email,
  }) = _User;
  
  factory User.fromJson(Map<String, dynamic> json) => 
      _$UserFromJson(json);
}
```

**3. Handle generation errors:**

If you encounter generation errors:

```bash
# Common error fixes
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs

# If still having issues, check for:
# - Missing imports in your code
# - Syntax errors in annotated classes
# - Conflicting file names
```

**4. Commit generated files:**

The template includes generated files in version control for easier collaboration. Make sure to:
- Run code generation before committing
- Include both source and generated files in commits
- Use `--delete-conflicting-outputs` to avoid merge conflicts

### Troubleshooting Code Generation

**Common Issues:**

1. **"Could not find part file"**:
   ```dart
   // Make sure you have the correct part directive
   part 'user_model.freezed.dart';
   part 'user_model.g.dart';
   ```

2. **"No top-level method 'build' declared"**:
   ```dart
   // Ensure your provider extends the generated class
   @riverpod
   class MyProvider extends _$MyProvider { // <- This line is important
     @override
     String build() => 'initial';
   }
   ```

3. **Build runner hangs**:
   ```bash
   # Kill the process and restart
   dart run build_runner clean
   # Then run build again
   ```

4. **Conflicting outputs**:
   ```bash
   # Always use --delete-conflicting-outputs
   dart run build_runner build --delete-conflicting-outputs
   ```

### IDE Integration

**VS Code users:**
- Install the "Dart Code" extension for better code generation support
- Use Cmd/Ctrl+Shift+P → "Dart: Run Build Runner" for quick access

**Android Studio/IntelliJ users:**
- Use the terminal or configure external tools for build runner commands

## Localization

The template uses easy_localization for internationalization.

### Setting Up Localization

The template includes automated localization setup. After adding translation keys, run:

```bash
# Generate localization keys
dart run easy_localization:generate \
  -S assets/translations \
  -f keys \
  -o locale_keys.g.dart \
  -O lib/src/localization
```

### Adding Translations

1. Add translation keys to `assets/translations/en.json`:

```json
{
  "common": {
    "ok": "OK",
    "cancel": "Cancel",
    "error": "Error"
  },
  "auth": {
    "login": "Log In",
    "logout": "Log Out",
    "email": "Email Address",
    "password": "Password"
  }
}
```

2. Add corresponding translations to other language files (e.g., `es.json`).

3. Run the localization generation command to create typed keys.

### Using Translations

```dart
// Import the generated keys
import '../localization/locale_keys.g.dart';

// In widgets using generated keys (recommended)
Text(LocaleKeys.auth_login.tr());
TextField(
  decoration: InputDecoration(
    labelText: LocaleKeys.auth_email.tr(),
  ),
);

// Using string keys (alternative)
Text('auth.login'.tr());

// With parameters
Text(LocaleKeys.greeting.tr(args: ['John'])); // "Hello, John!"

// With named parameters
Text(LocaleKeys.role.tr(namedArgs: {'role': 'Admin'})); // "Your role: Admin"
```

## Asset Management

The template uses flutter_gen for type-safe asset management.

### Setting Up Asset Generation

Run the following command after adding new assets:

```bash
# Using flutter_gen (recommended)
fluttergen -c pubspec.yaml

# Or using build_runner
dart run build_runner build -d
```

### Adding Assets

1. Add your assets to the appropriate directories:
   ```
   assets/
   ├── images/
   │   └── your_image.png
   ├── icons/
   │   └── your_icon.svg
   └── lottie/
       └── your_animation.json
   ```

2. Run the asset generation command.

3. Use the generated references:

```dart
// Type-safe asset access
Image.asset(Assets.images.yourImage);
SvgPicture.asset(Assets.icons.yourIcon);

// With error handling
Image.asset(
  Assets.images.profile,
  errorBuilder: (context, error, stackTrace) => 
    const Icon(Icons.error),
);
```

### Asset Organization Best Practices

1. **Group by purpose**: Keep related assets together
2. **Use descriptive names**: `user_profile_placeholder.png` instead of `img1.png`
3. **Optimize file sizes**: Use appropriate formats and compress images
4. **Provide multiple resolutions**: Use 1x, 2x, 3x versions for images

```dart
// Example of using different asset types
class AssetExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Regular image
        Image.asset(Assets.images.appLogo),
        
        // SVG icon
        SvgPicture.asset(
          Assets.icons.searchIcon,
          width: 24,
          height: 24,
        ),
        
        // Lottie animation
        Lottie.asset(
          Assets.lottie.errorLottie,
          repeat: false,
        ),
      ],
    );
  }
}
```

## Local Storage

The template includes shared_preferences and flutter_secure_storage for local storage.

### Using Local Storage

```dart
// Storing simple data
final prefs = await ref.read(sharedPreferencesProvider.future);
await prefs.setString('language', 'en');
await prefs.setBool('darkMode', true);

// Reading simple data
final language = prefs.getString('language') ?? 'en';
final isDarkMode = prefs.getBool('darkMode') ?? false;

// Secure storage for sensitive data
final secureStorage = ref.read(secureStorageProvider);
await secureStorage.write(key: 'token', value: 'jwt-token-here');
final token = await secureStorage.read(key: 'token');
```

## Flavors and Environment Configuration

The template supports multiple flavors (dev, staging, prod) for different environments.

### Using Environment Variables

```dart
// Access current flavor
final flavor = F.appFlavor;

// Conditionally show dev UI
if (F.isDev) {
  // Show debug panel
}

// Access environment-specific values
final apiUrl = Env.apiUrl;
final apiKey = Env.apiKey;
```

### Running with Different Flavors

```bash
# Development
flutter run --flavor dev -t lib/main.dart

# Staging
flutter run --flavor staging -t lib/main.dart

# Production
flutter run --flavor prod -t lib/main.dart
```

## Testing

The template includes a test structure for unit, widget, and integration tests.

### Unit Testing Example

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Test a service
void main() {
  late ProductService productService;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    productService = ProductService(mockRepository);
  });

  test('getProducts returns list of products', () async {
    // Arrange
    final mockProducts = [
      Product(id: '1', name: 'Test Product', price: 9.99),
    ];
    when(mockRepository.getProducts())
        .thenAnswer((_) async => mockProducts);

    // Act
    final result = await productService.getProducts();

    // Assert
    expect(result, equals(mockProducts));
    verify(mockRepository.getProducts()).called(1);
  });
}
```

### Widget Testing Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProductCard displays product information', (tester) async {
    // Arrange
    final product = Product(
      id: '1',
      name: 'Test Product',
      price: 9.99,
    );

    // Act
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProductCard(product: product),
        ),
      ),
    );

    // Assert
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('\$9.99'), findsOneWidget);
  });
}
```

## Conclusion

This guide covered the main aspects of working with this Flutter Riverpod Starter Template. For more information, refer to the code documentation within the template and the [ARCHITECTURE.md](./ARCHITECTURE.md) document.

Happy coding!
