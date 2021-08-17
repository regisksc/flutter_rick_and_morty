import 'package:flutter/material.dart';

import '../core/data/data.dart';
import '../core/data/network/network.dart';
// Project imports:
import '../core/env/flavors.dart';
import '../core/exports/exports.dart';
import '../core/presentation/presentation.dart';
import '../data/repositories/repositories.dart';
import '../domain/repositories/repositories.dart';
import '../domain/usecases/usecases.dart';
import '../presentation/presenters/characters_presenter.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Presenter presenter;
  late GetAllCharactersUsecase getAllCharacters;
  late GetSomeLocationsUsecase getSomeLocations;
  late GetSomeEpisodesUsecase getSomeEpisodes;
  late CharacterRepository characterRepository;
  late LocationRepository locationRepository;
  late EpisodeRepository episodeRepository;
  late ConnectionHandler connectionHandler;
  late RemoteDatasource remoteDatasource;
  late LocalDatasource localDatasource;
  late HttpClient http;
  @override
  void initState() {
    http = HttpAdapter(Dio());
    connectionHandler = ConnectionHandler(DataConnectionChecker());
    remoteDatasource = ConcreteRemoteDatasource(client: http);
    localDatasource = LocalDatasource(GetStorage());
    characterRepository = CharacterRepositoryImpl(
      connectionHandler: connectionHandler,
      remoteDataSource: remoteDatasource,
      localDataSource: localDatasource,
    );
    episodeRepository = EpisodeRepositoryImpl(
      connectionHandler: connectionHandler,
      localDataSource: localDatasource,
      remoteDataSource: remoteDatasource,
    );
    locationRepository = LocationRepositoryImpl(
      connectionHandler: connectionHandler,
      localDataSource: localDatasource,
      remoteDataSource: remoteDatasource,
    );
    getAllCharacters = GetAllCharactersUsecase(characterRepository);
    getSomeEpisodes = GetSomeEpisodesUsecase(episodeRepository);
    getSomeLocations = GetSomeLocationsUsecase(locationRepository);
    presenter = CharactersPresenter(
      getAllCharacters: getAllCharacters,
      getSomeLocations: getSomeLocations,
      getSomeEpisodes: getSomeEpisodes,
    );

    presenter.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppFlavor.title),
      ),
      body: Center(
        child: Text(
          'Hello ${AppFlavor.title}',
        ),
      ),
    );
  }
}
