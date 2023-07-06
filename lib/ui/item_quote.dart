import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/model/quote.dart';

class ItemQuote extends StatelessWidget {
  const ItemQuote({required this.quote, this.onTap, super.key});

  final Quote quote;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 150,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Text(quote.author?[0] ?? ''),
                ),
                const SizedBox(height: 10),
                const Text('bar')
              ],
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quote.author ?? '',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // name author
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'dg1',
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 0.8),
                    ),
                    const SizedBox(width: 5),
                    Text('dg2',
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 0.8))
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  'gia: 10,000',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quote.content,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text('(aaaaaaaaa)', textAlign: TextAlign.start),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: const Size(80, 20)),
                        child: const Text('Bt'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
