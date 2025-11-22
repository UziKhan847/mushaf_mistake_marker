import 'package:flutter/material.dart';

class MushafPageLoading extends StatelessWidget {
  const MushafPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: .center,
        spacing: 16,
        children: [CircularProgressIndicator(), Text('Loading Page')],
      ),
    );
  }
}
