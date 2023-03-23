import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:test_new_project/cocktail_feature/presentation/cubit/categories/categories.dart';
import '../../../di/createDependencies.dart';
import '../cubit/categories/categories_state.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetCategoriesCubit>(
      create: (context) => sl<GetCategoriesCubit>(),
      child: BlocBuilder<GetCategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if(state is Empty){
            BlocProvider.of<GetCategoriesCubit>(context).getRandom();
          }

          if (state is CategoriesLoaded) {
            return ListView(
              padding: EdgeInsets.all(AppLayout.getHeigth(20)),
              children: [
                const Gap(40),
                Text("Categories - ${state.categories}"),
              ],
            );
          }
          return const Text("Error");
        },
      ),
    );
  }
}