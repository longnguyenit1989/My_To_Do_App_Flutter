import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/ui/quote_detail.dart';

import '../bloc/quote_bloc.dart';
import '../model/quote.dart';

class QuotesList extends StatelessWidget {
  final QuoteBloc quoteBloc;

  const QuotesList({super.key, required this.quoteBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: quoteBloc.quotesController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Quote> quotes = snapshot.data ?? [];
            return ListView.separated(
              itemCount: quotes.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(quotes[index].content),
                  subtitle: Text(quotes[index].author ?? ""),
                  onTap: () {
                    Quote quoteClick = quotes[index];
                    QuoteDetail quoteDetail = QuoteDetail(
                        quoteBloc: quoteBloc, index: index, quote: quoteClick);
                    MaterialPageRoute route =
                        MaterialPageRoute(builder: (context) => quoteDetail);
                    Navigator.push(context, route);
                  },
                );
              },
            );
          } else {
            return const Center(child: Text("Hello world!"));
          }
        });
  }
}

// class QuotesList extends StatefulWidget {
//   final QuoteBloc quoteBloc;

//   const QuotesList({super.key, required this.quoteBloc});

//   @override
//   State<QuotesList> createState() => _QuotesListState();
// }

// class _QuotesListState extends State<QuotesList> {
//   @override
//   void initState() {
//     super.initState();
//     widget.quoteBloc.navigationController.stream
//         .asBroadcastStream()
//         .listen((event) {
//       if (event == "update") {
//         Navigator.pop(context);
//       } else if (event == "delete") {
//         Navigator.pop(context);
//         Navigator.pop(context);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: widget.quoteBloc.quotesController.stream,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<Quote> quotes = snapshot.data ?? [];
//             return ListView.separated(
//               itemCount: quotes.length,
//               separatorBuilder: (context, index) => const Divider(),
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(quotes[index].content),
//                   subtitle: Text(quotes[index].author ?? ""),
//                   onTap: () {
//                     Quote quoteClick = quotes[index];
//                     QuoteDetail quoteDetail = QuoteDetail(
//                         quoteBloc: widget.quoteBloc,
//                         index: index,
//                         quote: quoteClick);
//                     MaterialPageRoute route =
//                         MaterialPageRoute(builder: (context) => quoteDetail);
//                     Navigator.push(context, route);
//                   },
//                 );
//               },
//             );
//           } else {
//             return const Center(child: Text("Hello world!"));
//           }
//         });
//   }
// }
