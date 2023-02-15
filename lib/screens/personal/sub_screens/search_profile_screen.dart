import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakebook_frontend/blocs/search/search_bloc.dart';
import 'package:fakebook_frontend/blocs/search/search_event.dart';
import 'package:fakebook_frontend/constants/localdata/local_data.dart';
import 'package:fakebook_frontend/models/search_model.dart';
import 'package:flutter/material.dart';

import 'package:fakebook_frontend/screens/personal/widgets/personal_widgets.dart';
import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchProfileScreen extends StatefulWidget {
  @override
  State<SearchProfileScreen> createState() => _SearchProfileScreenState();
}

class _SearchProfileScreenState extends State<SearchProfileScreen> {
  static const historyLength = 5;

  List<String> _searchHistory = [
    'fuchshia',
    'flutter',
    'nodejs',
    'hello',
    'hmmmmmm'
  ];

  late List<String> filteredSearchHistory;

  String? selectedTerm;

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((element) => element == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  String? filter;

  List<String> filterSearchTerms({
    required filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void getHistory(BuildContext context) async {
    // List<SaveSearch> tempHistory = BlocProvider.of<SearchBloc>(context).add(GetSavedSearch());
    // _searchHistory = BlocProvider.of<SearchBloc>(context).add(GetSavedSearch());
  }

  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   backgroundColor: Colors.white,
      //   // title:
      //   // titleSpacing: 0.0,
      // ),
      body: FloatingSearchBar(
        height: 57,
        controller: controller,
        body: SearchResultListView(searchTerm: null),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        title: Text(
          selectedTerm ?? 'Search.....',
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: 'Search.....',
        actions: [FloatingSearchBarAction.searchToClear()],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
          });
          controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
                color: Colors.white,
                elevation: 4,
                child: Builder(
                  builder: (context) {
                    // _searchHistory = context.read<SearchBloc>().add(GetSavedSearch());
                    if (filteredSearchHistory.isEmpty &&
                        controller.query.isEmpty) {
                      return Container(
                        height: 56,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          'Start Searching',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      );
                    } else if (filteredSearchHistory.isEmpty) {
                      return ListTile(
                        title: Text(controller.query),
                        leading: const Icon(Icons.search),
                        onTap: () {
                          setState(() {
                            addSearchTerm(controller.query);
                            selectedTerm = controller.query;
                          });
                          controller.close();
                        },
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: filteredSearchHistory
                            .map((term) => ListTile(
                                  title: Text(
                                    term,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: const Icon(Icons.history),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        deleteSearchTerm(term);
                                      });
                                    },
                                  ),
                          onTap: () {
                                    setState(() {
                                      putSearchTermFirst(term);
                                      selectedTerm = term;
                                    });
                                    controller.close();
                          },
                                ))
                            .toList(),
                      );
                    }
                  },
                )),
          );
        },
      ),
    );
  }
}

class SearchResultListView extends StatelessWidget {
  final String? searchTerm;

  const SearchResultListView({Key? key, required this.searchTerm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class PostList extends StatefulWidget {
//   const PostList({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<PostList> createState() => _PostListState();
// }
//
// class _PostListState extends State<PostList> {
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PostBloc, PostState>(
//         builder: (context, state) {
//           // switch case hết giá trị thì BlocBuilder sẽ tự hiểu không bao giờ rơi vào trường hợp null ---> Siêu ghê
//           switch (state.status) {
//             case PostStatus.initial:
//               return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
//             case PostStatus.loading:
//               return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
//             case PostStatus.failure:
//               return const SliverToBoxAdapter(child: Center(child: Text('Failed to fetch posts')));
//             case PostStatus.success:
//               return SliverList(
//                   delegate: SliverChildBuilderDelegate((context, index) {
//                     return index >= state.postList.posts.length
//                         ? const BottomLoader()
//                         : PostContainer(post: state.postList.posts[index] as Post);
//                   },
//                       childCount: state.postList.posts.length)
//               );
//           // return const Center(child: Text('Successed to fetch posts'));
//           }
//         }
//     );
//   }
// }
