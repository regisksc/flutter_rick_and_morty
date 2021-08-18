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
  late CharactersPresenter _presenter;
  late GetAllCharactersUsecase _getAllCharacters;
  late GetSomeLocationsUsecase _getSomeLocations;
  late GetSomeEpisodesUsecase _getSomeEpisodes;
  late CharacterRepository _characterRepository;
  late LocationRepository _locationRepository;
  late EpisodeRepository _episodeRepository;
  late ConnectionHandler _connectionHandler;
  late RemoteDatasource _remoteDatasource;
  late LocalDatasource _localDatasource;
  late HttpClient _http;

  @override
  void initState() {
    super.initState();
    final dio = Dio();

    _http = HttpAdapter(dio);
    _connectionHandler = ConnectionHandler(DataConnectionChecker());
    _remoteDatasource = ConcreteRemoteDatasource(client: _http);
    _localDatasource = LocalDatasource(GetStorage());
    _characterRepository = CharacterRepositoryImpl(
      connectionHandler: _connectionHandler,
      remoteDataSource: _remoteDatasource,
      localDataSource: _localDatasource,
    );
    _episodeRepository = EpisodeRepositoryImpl(
      connectionHandler: _connectionHandler,
      localDataSource: _localDatasource,
      remoteDataSource: _remoteDatasource,
    );
    _locationRepository = LocationRepositoryImpl(
      connectionHandler: _connectionHandler,
      localDataSource: _localDatasource,
      remoteDataSource: _remoteDatasource,
    );
    _getAllCharacters = GetAllCharactersUsecase(_characterRepository);
    _getSomeEpisodes = GetSomeEpisodesUsecase(_episodeRepository);
    _getSomeLocations = GetSomeLocationsUsecase(_locationRepository);
    _presenter = CharactersPresenter(
      getAllCharacters: _getAllCharacters,
      getSomeLocations: _getSomeLocations,
      getSomeEpisodes: _getSomeEpisodes,
    );

    _presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: AppColors.lightGreenAcc,
          title: Center(child: Text(AppFlavor.title)),
        ),
        body: Center(
          child: StreamBuilder<UiStates>(
            stream: _presenter.pageState,
            builder: (_, state) {
              final characters = _presenter.entities as List<CharacterEntity>;
              switch (state.data) {
                case UiStates.error:
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: const Text(
                      'Oops, something happenned while fetching your data. Please try again!',
                      textAlign: TextAlign.center,
                    ),
                  );
                case UiStates.fullyLoaded:
                  return CharactersScrollWidget(
                    presenter: _presenter,
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
