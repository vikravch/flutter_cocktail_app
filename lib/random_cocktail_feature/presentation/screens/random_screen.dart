import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../di/createDependencies.dart';
import '../cubit/random_cocktail.dart';
import '../cubit/random_cocktail_state.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';

class RandomScreen extends StatelessWidget {
  const RandomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetRandomCubit>(
      create: (context) => sl<GetRandomCubit>(),
      child: BlocBuilder<GetRandomCubit, RandomCocktailState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if(state is Empty){
            BlocProvider.of<GetRandomCubit>(context).getRandom();
          }

          if (state is RandomCocktailLoaded) {
            return ListView(
              padding: EdgeInsets.all(AppLayout.getHeigth(20)),
              children: [
                const Gap(40),
                InkWell(
                  onTap: () {
                    BlocProvider.of<GetRandomCubit>(context).getRandom();
                  },
                  child: Center(
                    child: Text(
                      "Get random cocktail",
                      style: Style.textStyle.copyWith(
                          color: Style.primaryColor, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const Gap(20),
                Text("Name - ${state.cocktail.name}"),
                Text("Id - ${state.cocktail.id}"),
              ],
            );
          }
          return const Text("Error");
        },
      ),
    );
  }
}