import 'package:common_microfrontend/modules/user/domain/entities/module_auth_home_entity.dart';
import 'package:flutter/material.dart';
import 'package:home_microfrontend/app/home/domain/entity/module_data_entity.dart';
import 'package:home_microfrontend/app/home/domain/module_data_chain_node.dart';
import 'package:home_microfrontend/app/home/domain/use_case/get_enable_modules_auth_home_use_case.dart';
import 'package:home_microfrontend/app/home/presentation/components/custom_buttons/communication_button.dart';
import 'package:home_microfrontend/app/home/presentation/components/custom_buttons/grid_view_button.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class HomeButtonsWidget extends StatelessWidget {
  const HomeButtonsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final List<ModuleAuthHomeEntity> orderedButtonsList =
        GetEnableModulesAuthHomeUseCase().call();

    final ModuleDataChainNode moduleDataChainNode = ModuleDataChainNode();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: size.height * 0.4,
        width: size.width,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: orderedButtonsList.length,
          itemBuilder: (context, index) {
            final ModuleDataEntity? moduleData = moduleDataChainNode
                .moduleData(orderedButtonsList[index].appRoute ?? '');

            if (moduleData!.pathKey == "notification") {
              return const CommunicationButton();
            }

            return GridViewButton(
                moduleName: orderedButtonsList[index].appRoute ?? '');
          },
        ),
      ),
    );
  }
}

class HomeButtonsLoadingWidget extends StatelessWidget {
  const HomeButtonsLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: size.height * 0.3,
        width: size.width,
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const _LoadingButton()),
            Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const _LoadingButton()),
            Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const _LoadingButton()),
            Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const _LoadingButton()),
            Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const _LoadingButton()),
            Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const _LoadingButton()),
          ],
        ),
      ),
    );
  }
}

class _LoadingButton extends StatelessWidget {
  const _LoadingButton();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(1),
            offset: const Offset(0, 0),
            blurRadius: 8,
            spreadRadius: -6,
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: const SizedBox(
                height: 40,
                width: 40,
              ),
            ),
          ],
        ));
  }
}
