// Demo file showing how to use the persistent cache with countries API
// This demonstrates the integration of HiveStore-based persistent caching

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/countries_service.dart';
import '../domain/country.dart';

class CountriesDemo extends ConsumerStatefulWidget {
  const CountriesDemo({super.key});

  @override
  ConsumerState<CountriesDemo> createState() => _CountriesDemoState();
}

class _CountriesDemoState extends ConsumerState<CountriesDemo> {
  List<Country> countries = [];
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final countriesService = await ref.read(countriesServiceProvider.future);
      final loadedCountries = await countriesService.getCountries();

      setState(() {
        countries = loadedCountries;
        isLoading = false;
      });

      debugPrint('🌍 [DEMO] Loaded ${countries.length} countries');
    } catch (e) {
      setState(() {
        error = 'Failed to load countries: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _refreshCountries() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final countriesService = await ref.read(countriesServiceProvider.future);
      final loadedCountries = await countriesService.getCountriesFresh();

      setState(() {
        countries = loadedCountries;
        isLoading = false;
      });

      debugPrint(
        '🌍 [DEMO] Refreshed ${countries.length} countries from network',
      );
    } catch (e) {
      setState(() {
        error = 'Failed to refresh countries: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _clearCache() async {
    try {
      final countriesService = await ref.read(countriesServiceProvider.future);
      await countriesService.clearCache();

      // Reload after clearing cache
      await _loadCountries();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cache cleared and reloaded')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to clear cache: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries Demo - Persistent Cache'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshCountries,
            tooltip: 'Force refresh from network',
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearCache,
            tooltip: 'Clear cache',
          ),
        ],
      ),
      body: Column(
        children: [
          // Cache info banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💾 Persistent Cache with Hive',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'This data persists across app restarts and uses HiveStore for efficient storage.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child:
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : error != null
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            size: 48,
                            color: Colors.red.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(error!, textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadCountries,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        final country = countries[index];
                        return ListTile(
                          leading: Text(
                            country.flag,
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(country.name),
                          subtitle: Text('Code: ${country.code}'),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadCountries,
        tooltip: 'Reload from cache',
        child: const Icon(Icons.cached),
      ),
    );
  }
}
