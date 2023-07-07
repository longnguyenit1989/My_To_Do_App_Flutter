import 'package:flutter/material.dart';

import '../bloc/quote_bloc.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    required this.child,
    required this.quoteBloc,
    super.key,
  });

  final Widget child;
  final QuoteBloc quoteBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: quoteBloc.loadingStrController.stream,
      builder: (context, snapshot) {
        var loading = snapshot.data as bool;
        return Stack(
          children: [
            child,
            if (loading)
              const Opacity(
                opacity: 0.4,
                child: ModalBarrier(
                  dismissible: false,
                  color: Colors.black,
                ),
              ),
            if (loading)
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      }
    );
  }
}
