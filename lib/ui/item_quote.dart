import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    // child: Text(quote.author?[0] ?? '',
                    backgroundImage: NetworkImage("https://www.chudu24.com/wp-content/uploads/2017/03/canh-dep-nhat-ban-5.jpg"),
                  ),
                  const SizedBox(height: 10),
                  RatingBar.builder(
                    itemSize: 12.5,
                    itemCount: 5,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.grey,
                    ),
                    onRatingUpdate: (rating) {},
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quote.author ?? '',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                  const Text('gia: 10,000',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.only(left: 5, right: 10),
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
                              minimumSize: const Size(80, 25)),
                          child: const Text('Bt'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
