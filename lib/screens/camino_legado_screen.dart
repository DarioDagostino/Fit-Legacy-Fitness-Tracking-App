import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/nodo_notifier.dart';
import '../models/nodo_model.dart';

class CaminoLegadoScreen extends ConsumerStatefulWidget {
  const CaminoLegadoScreen({super.key});

  @override
  ConsumerState<CaminoLegadoScreen> createState() => _CaminoLegadoScreenState();
}

class _CaminoLegadoScreenState extends ConsumerState<CaminoLegadoScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      // close to bottom -> load more
      ref.read(nodoNotifierProvider.notifier).loadMore();
    }
  }

  Widget _buildContent(List<NodoModel> items, bool hasMore) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          title: const Text('Camino Legado'),
          backgroundColor: Colors.indigo,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index >= items.length) {
                // loading indicator at end
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final nodo = items[index];
              return ListTile(
                title: Text(nodo.title),
                subtitle: Text(nodo.description),
                leading: CircleAvatar(child: Text(nodo.id.split('-').last)),
              );
            },
            childCount: items.length + (hasMore ? 1 : 0),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(nodoNotifierProvider);

    return Scaffold(
      body: asyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (items) => _buildContent(items, ref.read(nodoNotifierProvider.notifier).hasMore),
      ),
    );
  }
}
