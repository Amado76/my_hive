import 'package:flutter/material.dart';

class PageCenterIndicator extends StatelessWidget {
  const PageCenterIndicator({
    super.key,
    this.onRefresh,
    required this.indicatorIcon,
    required this.indicatorText,
  });

  final Function? onRefresh;
  final Icon indicatorIcon;
  final Text indicatorText;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (onRefresh != null) onRefresh!();
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    indicatorIcon,
                    const SizedBox(height: 20),
                    indicatorText,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
