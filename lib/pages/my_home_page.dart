import 'dart:math';

import 'package:flutter/material.dart';

import '../core/data/data.dart';
import '../core/data/network/network.dart';
// Project imports:
import '../core/env/flavors.dart';
import '../core/exports/exports.dart';
import '../core/presentation/presentation.dart';
import '../core/resources/constants/constants.dart';
import '../data/repositories/repositories.dart';
import '../domain/entities/entities.dart';
import '../domain/repositories/repositories.dart';
import '../domain/usecases/usecases.dart';
import '../presentation/presenters/characters_presenter.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(title: Text(AppFlavor.title)),
      body: Center(
        child: StreamBuilder<UiStates>(
          stream: presenter.pageState,
          builder: (_, state) {
            final characters = presenter.entities as List<CharacterEntity>;
            switch (state.data) {
              case UiStates.partiallyLoaded:
                return const ColoredBox(color: Colors.yellow);
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
    );
  }
}

class CharactersScrollWidget extends StatefulWidget {
  const CharactersScrollWidget({
    Key? key,
    required this.size,
    required this.characters,
  }) : super(key: key);

  final Size size;
  final List<CharacterEntity> characters;

  @override
  _CharactersScrollWidgetState createState() => _CharactersScrollWidgetState();
}

class _CharactersScrollWidgetState extends State<CharactersScrollWidget> {
  late PageController pageController;
  double? _currentPage = 0;
  void _currentPageFeed() => setState(() => _currentPage = pageController.page);
  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.7);
    pageController.addListener(_currentPageFeed);
  }

  @override
  void dispose() {
    pageController.removeListener(_currentPageFeed);
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double _margin = 15;
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.characters.length,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        itemBuilder: (context, index) {
          final character = widget.characters[index];
          double percentage = index - (_currentPage ?? 0) + 1;
          percentage = pow(percentage, -1).toDouble();

          return Container(
            margin: const EdgeInsets.all(_margin),
            child: Center(
              child: SizedBox(
                height: widget.size.height / 1.8,
                width: widget.size.width,
                child: Transform(
                  transform: Matrix4.identity()
                    ..scale(percentage * .8)
                    ..translate(0.0, widget.size.height / 2 * (1 - percentage).abs())
                    ..setEntry(3, 2, .001),
                  child: AnimatedOpacity(
                    opacity: percentage.clamp(0, 1),
                    duration: const Duration(milliseconds: 250),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        final boxHeight = constraints.biggest.height;
                        final boxWidth = constraints.biggest.width;
                        return Transform.scale(
                          scale: 1.5,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                child: Image.network(
                                  character.image,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Positioned(
                                bottom: boxHeight / 1.8,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 15),
                                  height: boxHeight * .1,
                                  width: boxWidth / 2,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 35,
                                        offset: Offset(10, 0),
                                        spreadRadius: 15,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    character.name,
                                    style: Theme.of(context).textTheme.headline1,
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                child: Container(
                                  height: boxHeight / 2,
                                  width: boxWidth,
                                  decoration: BoxDecoration(
                                    color: AppColors.yellow,
                                    border: Border.all(
                                      color: Colors.blue,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                                  margin: EdgeInsets.only(top: boxHeight / 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CharacterInformationPill(label: 'Species', value: character.species),
                                      SizedBox(height: boxHeight * .03),
                                      CharacterInformationPill(label: 'Gender', value: character.gender),
                                      SizedBox(height: boxHeight * .03),
                                      CharacterInformationPill(label: 'Status', value: character.status),
                                      SizedBox(height: boxHeight * .03),
                                      CharacterInformationPill(label: 'Origin', value: character.origin?.name ?? '?'),
                                      SizedBox(height: boxHeight * .03),
                                      CharacterInformationPill(
                                        label: 'Last seen',
                                        value: character.location?.name ?? '?',
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CharacterInformationPill extends StatelessWidget {
  const CharacterInformationPill({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    final _labelBackgroundColor = AppColors.green;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(flex: 4, child: _Label(labelBackgroundColor: _labelBackgroundColor, labelText: label)),
          Expanded(flex: 6, child: _Content(labelBackgroundColor: _labelBackgroundColor, value: value)),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required Color? labelBackgroundColor,
    required this.value,
  })  : _labelBackgroundColor = labelBackgroundColor,
        super(key: key);

  final Color? _labelBackgroundColor;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: _labelBackgroundColor!),
        color: _labelBackgroundColor?.withOpacity(.2),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Text(
        value,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    Key? key,
    required Color? labelBackgroundColor,
    required this.labelText,
  })  : _labelBackgroundColor = labelBackgroundColor,
        super(key: key);

  final Color? _labelBackgroundColor;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: _labelBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Text(
        labelText,
        style: Theme.of(context).textTheme.subtitle1,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
