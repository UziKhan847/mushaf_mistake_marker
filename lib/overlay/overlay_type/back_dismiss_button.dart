import 'package:flutter/material.dart';

class BackDismissButton extends StatelessWidget {
  const BackDismissButton({super.key, required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.orientationOf(context) == .portrait;
    final srcSize = MediaQuery.sizeOf(context);

    return Positioned(
      top: 0,
      left: 0,
      child: SizedBox(
        height: isPortrait ? 50 : srcSize.height,
        width: isPortrait ? srcSize.width : 50,
        child: Flex(
          direction: isPortrait ? .horizontal : .vertical,
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          children: [
            Padding(
              padding: .only(
                top: isPortrait ? 0.0 : 25.0,
                left: isPortrait ? 10.0 : 0.0,
              ),
              child: IconButton(
                onPressed: onDismiss,
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
