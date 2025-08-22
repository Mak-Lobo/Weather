import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../custom_widget/custom_location_card.dart';
import '../services.dart';

class Locations extends ConsumerWidget {
  const Locations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _searchResults = ref.watch(resultsProvider);
    final TextEditingController controller = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverAppBar(
                floating: true,
                snap: true,
                title: const Text('Locations'),
                centerTitle: true,
                pinned: true,
                actions: (controller.text.isNotEmpty)
                    ? [IconButton(icon: Icon(Icons.search), onPressed: () {})]
                    : null,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.inversePrimary,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                  ),

                  onChanged: (value) {
                    ref.read(searchProvider.notifier).state = value;
                  },
                ),
              ),
            ),
            SliverPadding(padding: const EdgeInsets.all(8.0)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _searchResults.when(
                  data: (results) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 500,
                        minHeight: 300,
                        minWidth: 200,
                        maxWidth: 300,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: results!.length,
                        itemBuilder: (context, index) {
                          return LocationCard(
                            bgColor: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            locale: results[index]['LocalizedName'],
                            state:
                                results[index]['AdministrativeArea']['LocalizedName'],
                            country: results[index]['Country']['LocalizedName'],
                          );
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: Text(
                      'Error: $error',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  loading: () => Center(
                    child: Column(
                      children: [
                        SpinKitFadingCircle(
                          color: Theme.of(context).colorScheme.primary,
                          size: 50.0,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Text('Loading locations..'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
