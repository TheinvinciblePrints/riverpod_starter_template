# Flutter Riverpod Starter Template: Usage Guide

This guide provides detailed examples and best practices for using this Flutter Riverpod Starter Template.

## Table of Contents

1. [Authentication Flow](#authentication-flow)
2. [Routing](#routing)
3. [State Management](#state-management)
4. [Adding Features](#adding-features)
5. [Working with Network Requests](#working-with-network-requests)
6. [Error Handling](#error-handling)
7. [Localization](#localization)
8. [Local Storage](#local-storage)
9. [Flavors and Environment Configuration](#flavors-and-environment-configuration)
10. [Testing](#testing)

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

This template includes robust error handling for network requests and other operations.

### Network Error Handling

```dart
// Using the NetworkErrorHandler mixin
mixin class UserRepository with NetworkErrorHandler {
  Future<Result<User>> getUser(String id) async {
    return handleNetworkCall(() async {
      final response = await dio.get('/users/$id');
      return User.fromJson(response.data);
    });
  }
}
```

### Error Presentation

```dart
// In UI layer
errorAsync.when(
  data: (_) => const SizedBox.shrink(), // No error
  loading: () => const CircularProgressIndicator(),
  error: (error, stack) => switch (error) {
    NetworkFailure() => NetworkErrorWidget(
      message: error.message,
      onRetry: () => ref.refresh(userProvider),
    ),
    ValidationFailure() => FormErrorWidget(
      errors: error.validationErrors,
    ),
    _ => GenericErrorWidget(
      message: error.toString(),
    ),
  },
);
```

## Localization

The template uses easy_localization for internationalization.

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

### Using Translations

```dart
// Import the extension
import 'package:easy_localization/easy_localization.dart';

// In widgets
Text('auth.login'.tr());
TextField(
  decoration: InputDecoration(
    labelText: 'auth.email'.tr(),
  ),
);

// With parameters
Text('greeting'.tr(args: ['John'])); // "Hello, John!"

// With named parameters
Text('role'.tr(namedArgs: {'role': 'Admin'})); // "Your role: Admin"
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
