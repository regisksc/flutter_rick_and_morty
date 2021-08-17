import 'package:flutter/foundation.dart';

import '../../core/domain/domain.dart';
import '../../core/exports/app_dependencies.dart';
import '../../core/presentation/presentation.dart';
import '../../domain/domain.dart';
import '../../domain/usecases/usecases.dart';

class CharactersPresenter implements Presenter {
  CharactersPresenter({
    required this.getAllCharacters,
    required this.getSomeLocations,
    required this.getSomeEpisodes,
  });
  final GetAllCharactersUsecase getAllCharacters;
  final GetSomeLocationsUsecase getSomeLocations;
  final GetSomeEpisodesUsecase getSomeEpisodes;

  @override
  int currentPage = 1;

  @override
  final entities = <CharacterEntity>[];

  @override
  Future onInit() async {
    final charactersCandidate = await _loadCharacters();
    if (charactersCandidate is Failure) pageState.value = UiStates.error;
    if (charactersCandidate is! Failure) {
      final characters = charactersCandidate as List<CharacterEntity>;
      pageState.value = UiStates.partiallyLoaded;
      final listOfQueries = <Future>[];
      _organizeRemainingDataFetchingTasks(characters, listOfQueries);
      _executeRemainingDataFetchingTasks(listOfQueries);
      pageState.value = UiStates.fullyLoaded;
    }
  }

  void _executeRemainingDataFetchingTasks(List<Future<dynamic>> listOfQueries) {
    Future.wait(listOfQueries);
  }

  void _organizeRemainingDataFetchingTasks(List<CharacterEntity> characters, List<Future<dynamic>> listOfQueries) {
    characters
      ..forEach(
        (character) {
          _fillLastSeenLocation(listOfQueries, character);
          _fillOriginaryLocation(listOfQueries, character);
          _fillFeaturedEpisodes(listOfQueries, character);
        },
      );
  }

  void _fillFeaturedEpisodes(List<Future<dynamic>> listOfQueries, CharacterEntity character) {
    return listOfQueries.add(
      getSomeEpisodes(character.featuredEpisodeIds).then(
        (value) => value.fold(
          (failure) => failure,
          (episodes) => character.episodes = episodes,
        ),
      ),
    );
  }

  void _fillOriginaryLocation(List<Future<dynamic>> listOfQueries, CharacterEntity character) {
    return listOfQueries.add(
      getSomeLocations([character.originaryLocationId]).then(
        (value) => value.fold(
          (failure) => failure,
          (location) => location.isEmpty ? null : character.origin = location[0],
        ),
      ),
    );
  }

  void _fillLastSeenLocation(List<Future<dynamic>> listOfQueries, CharacterEntity character) {
    return listOfQueries.add(
      getSomeLocations([character.lastLocationId]).then(
        (value) => value.fold(
          (failure) => failure,
          (location) => location.isEmpty ? null : character.location = location[0],
        ),
      ),
    );
  }

  Future<Object> _loadCharacters() async {
    final getCharacters = getAllCharacters(currentPage);
    final characters = await getCharacters;
    final extract = characters.fold(id, id);
    return extract;
  }

  @override
  ValueNotifier<UiStates> get pageState => ValueNotifier(UiStates.initial);
}
