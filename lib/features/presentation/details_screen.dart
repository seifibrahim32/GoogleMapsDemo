import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/data_sources/data_source.dart';
import 'bloc/place_details.dart';
import 'bloc/states/places_states.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Map? data;

  TextStyle? getProductSans(
      {double fontSize = 26, Color color = Colors.black}) {
    return TextStyle(
        fontFamily: 'Product Sans', fontSize: fontSize, color: color);
  }

  final List<Widget> days = [];

  getBorder(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 2,
        color: Colors.grey);
  }

  getData(context) {
    data = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{})
        as Map;
  }

  @override
  Widget build(BuildContext context) {
    getData(context);

    return BlocProvider(
      create: (BuildContext context) => DetailsMapsCubit(),
      child: BlocBuilder<DetailsMapsCubit, DetailsStates>(
        builder: (ctx, state) {
          if (state is DetailsLoading) {
            BlocProvider.of<DetailsMapsCubit>(ctx).loadData(data!['placeId']);
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is DataLoaded) {
            if (days.isNotEmpty) {
              days.clear();
            }
            var data = state.data!;
            if (data['result']['current_opening_hours']['open_now'] == true) {
              days.add(Text('Currently Open',
                  style: getProductSans(fontSize: 14, color: Colors.green)));
            } else {
              days.add(Text('Closed',
                  style: getProductSans(fontSize: 14, color: Colors.red)));
            }
            for (var duration in List.of(
                data['result']['current_opening_hours']['weekday_text'])) {
              days.add(Text(duration, style: getProductSans(fontSize: 14)));
            }
            List photos = List.of(data['result']['photos']);

            return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  elevation: 3,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 340,
                        child: ListView.separated(
                          shrinkWrap: true,
                          primary: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                width: 444,
                                height: photos[index]['height'].toDouble() / 5,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: ClipRRect(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  child: Image.network(
                                    'https://maps.googleap'
                                    'is.com/maps/api/place/photo?maxw'
                                    'idth=${photos[index]['width']}&photo_reference=${photos[index]['photo_reference']}'
                                    '&key=${MapsAPI.apiKey}',
                                    fit: BoxFit.fill,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ));
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 10);
                          },
                          itemCount: photos.length,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['result']['name']! ?? '',
                                    style: getProductSans(fontSize: 30)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.stars, color: Colors.amber),
                                      SizedBox(width: 14),
                                      Text(
                                          data['result']['rating'].toString() +
                                              ' /5',
                                          softWrap: true,
                                          maxLines: 2,
                                          style: getProductSans(fontSize: 18)),
                                    ],
                                  ),
                                ),
                                getBorder(context),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.place, color: Colors.blue),
                                      SizedBox(width: 14),
                                      Flexible(
                                        child: Text(
                                            data['result']['vicinity'] ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                            style:
                                                getProductSans(fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                                getBorder(context),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.timer,
                                          color: Colors.deepOrange),
                                      SizedBox(width: 14),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: days,
                                      ),
                                    ],
                                  ),
                                ),
                                getBorder(context),
                                SizedBox(height: 40),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text('© 2023 All rights reserved to ',
                                          style: getProductSans(fontSize: 13)),
                                      Image.network(
                                        'https://www.google.com/images/branding/googlelogo/'
                                        '1x/googlelogo_light_color_272x92dp.png',
                                        color: Colors.purple,
                                        alignment: Alignment.bottomCenter,
                                        isAntiAlias: true,
                                        scale: 5.0,
                                      ),
                                    ]),
                                SizedBox(height: 40),
                              ])),
                    ],
                  ),
                ));
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
