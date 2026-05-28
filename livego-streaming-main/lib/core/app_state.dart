// lib/core/app_state.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/drama_repository.dart';

class AppState extends ChangeNotifier {
  List<String> _activePlatformIds = Platforms.defaultTvHomeIds;
  String _selectedPlatform = Platforms.defaultTvHomeIds.first;
  String _selectedCategory = 'trending';
  List _dramas = [];
  bool _isLoading = false;
  List<Map<String, dynamic>> _favorites = [];
  List<Map<String, dynamic>> _history = [];

  List<String> get activePlatformIds => _activePlatformIds;
  String get selectedPlatform => _selectedPlatform;
  String get selectedCategory => _selectedCategory;
  List get dramas => _dramas;
  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get favorites => _favorites;
  List<Map<String, dynamic>> get history => _history;

  List<PlatformConfig> get activePlatforms => _activePlatformIds
      .map((id) => Platforms.findById(id))
      .whereType<PlatformConfig>()
      .toList();

  List<CategoryConfig> get activeCategories {
    final p = Platforms.findById(_selectedPlatform);
    return p?.categories ?? [];
  }

  Future<void> init({bool isTV = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = isTV ? 'tv_active_platforms_v2' : 'mobile_active_platforms_v2';
    final saved = prefs.getStringList(key);
    _activePlatformIds = (saved != null && saved.isNotEmpty)
        ? saved
        : (isTV ? Platforms.defaultTvHomeIds : Platforms.defaultMobileHomeIds);
    _selectedPlatform = _activePlatformIds.first;
    final p = Platforms.findById(_selectedPlatform);
    _selectedCategory = p?.categories.isNotEmpty == true ? p!.categories.first.id : 'trending';
    await _loadFavorites();
    await _loadHistory();
    await loadDramas();
  }

  Future<void> loadDramas({bool refresh = false}) async {
    _isLoading = true;
    notifyListeners();
    try {
      _dramas = await DramaRepository.getByCategory(_selectedPlatform, _selectedCategory);
    } catch (_) { _dramas = []; }
    _isLoading = false;
    notifyListeners();
  }

  void changePlatform(String id) {
    if (_selectedPlatform == id) return;
    _selectedPlatform = id;
    final p = Platforms.findById(id);
    _selectedCategory = p?.categories.isNotEmpty == true ? p!.categories.first.id : 'trending';
    loadDramas();
  }

  void changeCategory(String id) {
    if (_selectedCategory == id) return;
    _selectedCategory = id;
    loadDramas();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList('favorites_v2') ?? [];
    _favorites = raw.map((e) {
      try { return Map<String, dynamic>.from(Uri.splitQueryString(e)); }
      catch (_) { return <String, dynamic>{}; }
    }).where((m) => m.isNotEmpty).toList();
  }

  bool isFavorite(String id, String source) =>
      _favorites.any((f) => f['id'] == id && f['source'] == source);

  Future<void> toggleFavorite(Map<String, dynamic> drama, String source) async {
    final prefs = await SharedPreferences.getInstance();
    final id = drama['id']?.toString() ?? '';
    if (isFavorite(id, source)) {
      _favorites.removeWhere((f) => f['id'] == id && f['source'] == source);
    } else {
      _favorites.insert(0, {'id': id, 'source': source,
        'title': drama['title'] ?? '', 'cover': drama['cover'] ?? ''});
    }
    await prefs.setStringList('favorites_v2',
        _favorites.map((f) => Uri(queryParameters:
            f.map((k, v) => MapEntry(k, v.toString()))).query).toList());
    notifyListeners();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList('history_v2') ?? [];
    _history = raw.map((e) {
      try { return Map<String, dynamic>.from(Uri.splitQueryString(e)); }
      catch (_) { return <String, dynamic>{}; }
    }).where((m) => m.isNotEmpty).toList();
  }

  Future<void> addHistory(Map<String, dynamic> drama, String source) async {
    final prefs = await SharedPreferences.getInstance();
    final id = drama['id']?.toString() ?? '';
    _history.removeWhere((h) => h['id'] == id && h['source'] == source);
    _history.insert(0, {'id': id, 'source': source,
      'title': drama['title'] ?? '', 'cover': drama['cover'] ?? '',
      'watched_at': DateTime.now().toIso8601String()});
    if (_history.length > 100) _history = _history.take(100).toList();
    await prefs.setStringList('history_v2',
        _history.map((h) => Uri(queryParameters:
            h.map((k, v) => MapEntry(k, v.toString()))).query).toList());
    notifyListeners();
  }

  Future<void> saveActivePlatforms(List<String> ids, {bool isTV = false}) async {
    final prefs = await SharedPreferences.getInstance();
    _activePlatformIds = ids;
    _selectedPlatform = ids.first;
    await prefs.setStringList(
        isTV ? 'tv_active_platforms_v2' : 'mobile_active_platforms_v2', ids);
    await loadDramas();
  }
}
