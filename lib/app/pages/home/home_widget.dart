import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_fonts/app/pages/home/blocs/fetch_bloc.dart';
import 'package:my_fonts/app/pages/home/cubits/search_cubit.dart';

import 'widgets/font_list_tile/font_list_tile_widget.dart';

class HomeWidget extends StatelessWidget {
  final textController = TextEditingController();

  late final _scrollController = ScrollController()
    ..addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        GetIt.I.get<SearchCubit>().fetch();
      }
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    onSubmitted: (text) {
                      GetIt.I.get<SearchCubit>().search(text);
                    },
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        GetIt.I.get<SearchCubit>().search(textController.text);
                      },
                      child: Text("SEARCH")),
                )
              ],
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder(
                bloc: GetIt.I.get<FetchBloc>(),
                builder: (context, state) {
                  if (state is FetchInitial) {
                    return Center(
                      child: Text("Search for a font!"),
                    );
                  } else if (state is FetchError) {
                    return Center(
                      child: Text("An error has occurred."),
                    );
                  } else if (state is FetchSuccess) {
                    final fonts = state.fonts;
                    final highlight = state.highlight;
                    return state.hasResults
                        ? Scrollbar(
                            controller: _scrollController,
                            child: ListView.builder(
                                controller: _scrollController,
                                itemCount: state.hasReachedMax
                                    ? fonts.length
                                    : fonts.length + 1,
                                itemBuilder: (_, index) {
                                  if (index >= fonts.length) {
                                    return Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(),
                                    ));
                                  } else {
                                    return FontListTileWidget(
                                      font: fonts.elementAt(index),
                                      highlight: highlight,
                                    );
                                  }
                                }),
                          )
                        : Center(
                            child: Text("No results."),
                          );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
