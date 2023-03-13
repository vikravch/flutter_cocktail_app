import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:test_new_project/domain/entity/cocktail.dart';
import 'package:test_new_project/domain/usecase/get_random_cocktail.dart';
import 'package:test_new_project/presentation/utils/app_layout.dart';
import '../../data/repository/cocktail_repository.dart';
import '../utils/app_styles.dart';
class RandomScreen extends StatefulWidget {
  const RandomScreen({Key? key}) : super(key: key);

  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  Cocktail? _cocktail;

  void _onGetTapped() async{
    var useCase = GetRandomCocktail(repository: CocktailRepositoryImpl());
    var res = await useCase();
    setState((){
      _cocktail = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,
      body: ListView(
        padding: EdgeInsets.all(AppLayout.getHeigth(20)),
        children: [
          const Gap(40),
          InkWell(
            onTap: _onGetTapped,
            child: Center(
              child: Text(
                "Get random cocktail",
                style: Style.textStyle.copyWith(
                    color: Style.primaryColor, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          (_cocktail!=null)?
              Column(
                children: [
                  const Gap(20),
                  Text("Name - ${_cocktail?.name}"),
                  Text("Id - ${_cocktail?.id}"),
                ],
              ):const Text("Generate new cocktail"),
        ],
      ),
    );
  }
}