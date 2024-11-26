import 'package:flutter/material.dart';
import 'package:home_microfrontend/app/home/domain/module_data_chain_node.dart';
import 'package:home_microfrontend/app/home/domain/entity/module_data_entity.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class GridViewButton extends StatelessWidget {
  const GridViewButton({super.key, required this.moduleName});
  final String moduleName;

  @override
  Widget build(BuildContext context) {
    final NavigationInjector navigator = Modular.get<NavigationInjector>();
    final ModuleDataChainNode moduleDataChainNode = ModuleDataChainNode();
    final ModuleDataEntity? moduleData =
        moduleDataChainNode.moduleData(moduleName);
    final String pathIcon = moduleData?.pathIcon ?? "assets/icons/person.png";
    final String textIcon = moduleData?.moduleName ?? "";

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Modular.to.pushNamed(
            navigator.getPath(
                package: moduleData!.package, pathKey: moduleData.pathKey),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            moduleData == null
                ? const SizedBox(
                    height: 40,
                  )
                : SizedBox(
                    height: 40,
                    child: Image.asset(
                      fit: BoxFit.fill,
                      pathIcon,
                      package: "home_microfrontend",
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(textIcon,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
