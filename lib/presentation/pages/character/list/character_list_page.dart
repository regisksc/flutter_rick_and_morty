import 'package:flutter/material.dart';

import '../../../../core/data/data.dart';
import '../../../../core/env/flavors.dart';
import '../../../../core/exports/exports.dart';
import '../../../../core/presentation/presentation.dart';
import '../../../../core/resources/constants/constants.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../domain/domain.dart';
import '../../../presenters/characters_presenter.dart';
import '../character.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({Key? key}) : super(key: key);

  @override
  _CharacterListPageState createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  late CharactersPresenter presenter;
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
    super.initState();
    final dio = Dio();
    // dio.interceptors..add(logginInterceptor());

    http = HttpAdapter(dio);
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightGreenAcc,
          title: Center(child: Text(AppFlavor.title)),
        ),
        body: Center(
          child: StreamBuilder<UiStates>(
            stream: presenter.pageState,
            builder: (_, state) {
              final characters = presenter.entities as List<CharacterEntity>;
              switch (state.data) {
                case UiStates.fullyLoaded:
                  return CharactersScrollWidget(
                    size: size,
                    characters: characters,
                  );
                default:
                  return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
