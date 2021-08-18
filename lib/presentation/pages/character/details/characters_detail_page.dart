import 'package:flutter/material.dart';

import '../../../../core/resources/constants/constants.dart';
import '../../../../domain/domain.dart';
import '../../../presentation.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({Key? key, required this.character}) : super(key: key);
  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.yellow,
        appBar: AppBar(
          backgroundColor: AppColors.lightGreenAcc,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.close,
                color: AppColors.green,
              ),
            )
          ],
          title: Center(
            child: Hero(
              tag: character.name,
              child: Text(
                character.name,
                style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18, letterSpacing: .5),
                overflow: TextOverflow.clip,
                maxLines: 2,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Hero(
                tag: '${character.id}-${character.name}',
                child: Image.network(
                  character.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                margin: EdgeInsets.all(size.shortestSide * .08),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      BasicCharacterInformation(character: character),
                      SizedBox(height: MediaQuery.of(context).size.height * .02),
                      Text(
                        'Appeared in:',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 14, letterSpacing: .5, color: Colors.black),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * .02),
                      Wrap(
                        children: character.episodes
                                ?.map(
                                  (episode) => Container(
                                    padding: const EdgeInsets.all(6),
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      episode.episode,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 12, color: AppColors.lightGreenAcc),
                                    ),
                                  ),
                                )
                                .toList() ??
                            [const Text('no episode found [?]')],
                      )
                    ],
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
