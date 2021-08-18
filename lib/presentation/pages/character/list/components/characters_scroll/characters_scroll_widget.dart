import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../../core/resources/constants/constants.dart';
import '../../../../../../domain/entities/entities.dart';
import '../../../character.dart';

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
        physics: const BouncingScrollPhysics(),
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
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(milliseconds: 1000),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  animation = CurvedAnimation(parent: animation, curve: Curves.elasticOut);
                                  return ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return CharacterDetailsPage(character: character);
                                },
                              ),
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: Hero(
                                    tag: '${character.id}-${character.name}',
                                    child: Image.network(
                                      character.image,
                                      fit: BoxFit.fitWidth,
                                    ),
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
                                ),
                              ],
                            ),
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
