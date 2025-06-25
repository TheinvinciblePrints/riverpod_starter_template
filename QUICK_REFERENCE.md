# Flutter Riverpod Starter Template: Quick Reference

This quick reference provides code snippets and patterns for common tasks when working with this starter template.

## Navigation

```dart
// Basic navigation
context.go(AppRoute.home.path);

// Named navigation with parameters
context.goNamed(
  AppRoute.details.name,
  pathParameters: {'id': itemId},
);

// Navigation with extra data (not in URL)
context.go(
  AppRoute.login.path,
  extra: {'message': 'Session expired'},
);

// Adding redirect logic
redirect: (context, state) {
  if (!isLoggedIn && state.uri.path.startsWith('/protected')) {
    return '/login';
  }
  return null;
}
```

## State Management with Riverpod

```dart
// Simple provider
@riverpod
String userName(Ref ref) => 'John Doe';

// Class-based provider
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;
  
  void increment() => state++;
}

// Future provider
@riverpod
Future<List<Item>> items(Ref ref) async {
  final repository = ref.watch(itemRepositoryProvider);
  return repository.getItems();
}

// Provider with parameters
@riverpod
Future<Item> item(Ref ref, {required String id}) {
  final repository = ref.watch(itemRepositoryProvider);
  return repository.getItemById(id);
}

// Using providers
final userName = ref.watch(userNameProvider);
final counter = ref.watch(counterProvider);
final items = ref.watch(itemsProvider);
final item = ref.watch(itemProvider(id: '123'));

// Accessing methods on notifiers
ref.read(counterProvider.notifier).increment();

// Handling async data
itemsAsync.when(
  data: (items) => ItemsList(items: items),
  loading: () => const LoadingIndicator(),
  error: (error, stack) => ErrorWidget(message: error.toString()),
);
```

## Network Requests

```dart
// GET request
final result = await _apiClient.getResult<List<Product>>(
  '/products',
  fromJson: (json) => (json as List)
      .map((item) => Product.fromJson(item))
      .toList(),
);

// POST request with data
final result = await _apiClient.postResult<User>(
  '/users',
  data: {'name': 'John', 'email': 'john@example.com'},
  fromJson: User.fromJson,
);

// Using results
return switch (result) {
  Success(data: final data) => data,
  Error(error: final error) => throw error,
};
```

## Error Handling

```dart
// Network error handler
mixin class MyRepository with NetworkErrorHandler {
  Future<Result<Data>> fetchData() {
    return handleNetworkCall(() async {
      final response = await dio.get('/data');
      return Data.fromJson(response.data);
    });
  }
}

// Error presentation in UI
@riverpod
class ErrorHandler extends _$ErrorHandler {
  @override
  String? build() => null;
  
  void setError(String message) => state = message;
  void clearError() => state = null;
}

// Usage in UI
final errorMessage = ref.watch(errorHandlerProvider);
if (errorMessage != null) {
  return ErrorBanner(message: errorMessage);
}
```

## Local Storage

```dart
// Shared Preferences
final prefs = await ref.read(sharedPreferencesProvider.future);

// Store data
await prefs.setString('key', 'value');
await prefs.setBool('flag', true);

// Read data
final value = prefs.getString('key');
final flag = prefs.getBool('flag') ?? false;

// Secure Storage (for sensitive data)
final secureStorage = ref.read(secureStorageProvider);

// Store secure data
await secureStorage.write(key: 'token', value: tokenValue);

// Read secure data
final token = await secureStorage.read(key: 'token');
```

## Authentication

```dart
// Login
ref.read(authenticationProvider.notifier).login();

// Logout
ref.read(authenticationProvider.notifier).logout();

// Check auth state
final authState = ref.watch(authenticationProvider);
return switch (authState) {
  AuthenticationAuthenticated(user: final user) => 
      AuthenticatedWidget(user: user),
  _ => LoginScreen(),
};

// Access current user
final user = ref.watch(currentUserProvider);
```

## Localization

```dart
// Using simple keys
Text('welcome'.tr());

// Using nested keys
Text('auth.login.title'.tr());

// With parameters
Text('greeting'.tr(args: ['John']));

// Named parameters
Text('message'.tr(namedArgs: {'name': 'John', 'count': '5'}));

// Formatting dates and numbers
final dateStr = DateFormat.yMd().format(date).tr();
final costStr = NumberFormat.currency(symbol: '$').format(cost).tr();
```

## Forms

```dart
// Form with validation
@riverpod
class LoginForm extends _$LoginForm {
  @override
  LoginFormState build() => const LoginFormState();
  
  void setEmail(String email) {
    state = state.copyWith(
      email: email,
      emailError: _validateEmail(email),
    );
  }
  
  void setPassword(String password) {
    state = state.copyWith(
      password: password,
      passwordError: _validatePassword(password),
    );
  }
  
  String? _validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!email.contains('@')) return 'Invalid email format';
    return null;
  }
  
  bool get isValid => 
      state.emailError == null && 
      state.passwordError == null &&
      state.email.isNotEmpty &&
      state.password.isNotEmpty;
}

// In UI
final form = ref.watch(loginFormProvider);
TextField(
  onChanged: (value) => 
      ref.read(loginFormProvider.notifier).setEmail(value),
  decoration: InputDecoration(
    errorText: form.emailError,
  ),
);

ElevatedButton(
  onPressed: form.isValid 
      ? () => ref.read(authenticationProvider.notifier).login()
      : null,
  child: Text('Login'),
);
```

## Flavors

```dart
// Check current flavor
if (F.isDev) {
  // Show debug menu
}

// Access flavor-specific values
switch (F.appFlavor) {
  case Flavor.dev:
    return 'Development';
  case Flavor.staging:
    return 'Staging';
  case Flavor.prod:
    return 'Production';
}

// Access environment variables
final apiUrl = Env.apiUrl;
```

## Creating New Features

1. Create folder structure
```
lib/src/features/feature_name/
├── application/  (Services, business logic)
├── data/         (Repositories, data sources)
├── domain/       (Models, entities)
└── presentation/ (UI components)
```

2. Create models with Freezed
```dart
@freezed
class MyModel with _$MyModel {
  const factory MyModel({
    required String id,
    required String name,
    @Default(false) bool isActive,
  }) = _MyModel;
  
  factory MyModel.fromJson(Map<String, dynamic> json) => 
      _$MyModelFromJson(json);
}
```

3. Add to router
```dart
GoRoute(
  path: '/feature-name',
  name: 'feature-name',
  builder: (_, __) => const FeatureScreen(),
),
```

## Running Code Generation

```bash
# Run build_runner once
dart run build_runner build --delete-conflicting-outputs

# Watch for changes
dart run build_runner watch --delete-conflicting-outputs
```

## Testing

```bash
# Run all tests
flutter test

# Run specific tests
flutter test test/features/authentication/

# Run with coverage
flutter test --coverage
```
