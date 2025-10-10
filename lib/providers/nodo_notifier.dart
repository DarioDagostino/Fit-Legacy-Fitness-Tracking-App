import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/nodo_model.dart';

final nodoNotifierProvider = AsyncNotifierProvider<NodoNotifier, List<NodoModel>>(() => NodoNotifier());

class NodoNotifier extends AsyncNotifier<List<NodoModel>> {
  static const int _pageSize = 20;
  int _page = 0;
  bool _hasMore = true;
  final List<NodoModel> _items = [];

  @override
  FutureOr<List<NodoModel>> build() async {
    // initial load
    _page = 0;
    _hasMore = true;
    _items.clear();
    return await _fetchNextPage();
  }

  Future<List<NodoModel>> _fetchNextPage() async {
    if (!_hasMore) return _items;
    state = const AsyncValue.loading();

    try {
      // simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // simulate fetched items
      final fetched = List.generate(_pageSize, (index) {
        final id = 'n-${_page * _pageSize + index}';
        return NodoModel(id: id, title: 'Nodo $id', description: 'Descripción del nodo $id');
      });

      if (fetched.isEmpty) {
        _hasMore = false;
      } else {
        _items.addAll(fetched);
        _page++;
        if (fetched.length < _pageSize) _hasMore = false;
      }

      state = AsyncValue.data(List.unmodifiable(_items));
      return _items;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;
    await _fetchNextPage();
  }

  bool get hasMore => _hasMore;
}
