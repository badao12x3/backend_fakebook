import 'package:fakebook_frontend/blocs/search/search_event.dart';
import 'package:fakebook_frontend/blocs/search/search_state.dart';
import 'package:fakebook_frontend/models/search_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/search_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  late final SearchRepository searchRepository;

  SearchBloc() : super(SearchState.initial()) {
    searchRepository = SearchRepository();

    on<Search>(_onSearch);
    on<GetSavedSearch>(_onGetSavedSearch);
  }

  Future<void> _onGetSavedSearch(
      GetSavedSearch event, Emitter<SearchState> emit) async {
    try {
      final searchListData = await searchRepository.fetchSaveSearchList();
      emit(state.copyWith(searchStatus: SearchStatus.loading));
      return emit(SearchState(
          searchStatus: SearchStatus.success, saveSearches: searchListData));
    } catch (_) {
      emit(SearchState(searchStatus: SearchStatus.failure));
    }
  }

  Future<void> _onSearch(Search event, Emitter<SearchState> emit) async {
    final keyword = event.keyword;
    try {
      final postListData = await searchRepository.searchSth(keyword: keyword);
      // lọc tất cả các bài viết bị banned
      final mustFilteredPosts = postListData;
      mustFilteredPosts?.retainWhere(
          (post) => post.banned == false && post.isBlocked == false);
      // print('Length: ${postList.posts.length}');
      emit(state.copyWith(searchStatus: SearchStatus.loading));
      return emit(
        SearchState(
          searchStatus: SearchStatus.success,
          postList: mustFilteredPosts,
        ),
      );
    } catch (_) {
      emit(SearchState(searchStatus: SearchStatus.failure));
    }
  }
}
