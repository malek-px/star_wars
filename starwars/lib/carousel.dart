import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Carousel extends StatefulWidget {
  @override
  State<Carousel> createState() => _CarouselState();
}

late final List<Character> photos = [];

Future<List<Character>> fetchPhotos(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://rawcdn.githack.com/akabab/starwars-api/0.2.1/api/all.json'));

  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parsePhotos, response.body);
}

// A function that will convert a response body into a List<Photo>
List<Character> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Character>((json) => Character.fromJson(json)).toList();
}

class Character {
  final int id;
  final String name;
  final String image;
  final String wiki;
  final String homeworld;
  
  //final int died;
  var affiliations = [];

  Character({
    required this.id,
    required this.name,
    required this.image,
    required this.wiki,
    //required this.died,
    required this.affiliations,
    required this.homeworld,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      wiki: json['wiki'] as String,
      homeworld: json['wiki'] as String,
      affiliations: json['affiliations'] as List,
      // died: json['died'] as int,
    );
  }
}
 final List<String> imgList = [
      'https://vignette.wikia.nocookie.net/starwars/images/2/20/LukeTLJ.jpg',
      'https://vignette.wikia.nocookie.net/starwars/images/6/6f/Anakin_Skywalker_RotS.png',
      'https://vignette.wikia.nocookie.net/starwars/images/0/00/BiggsHS-ANH.png',
      'https://vignette.wikia.nocookie.net/fr.starwars/images/3/32/Dark_Vador.jpg',
      'https://vignette.wikia.nocookie.net/starwars/images/f/fc/Leia_Organa_TLJ.png',
      'https://vignette.wikia.nocookie.net/starwars/images/e/eb/OwenCardTrader.png',
      'https://vignette.wikia.nocookie.net/starwars/images/c/cc/BeruCardTrader.png',
      'https://vignette.wikia.nocookie.net/starwars/images/4/4e/ObiWanHS-SWE.jpg'
    ];

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 50.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();

class _CarouselState extends State<Carousel> {
  int _value = 1;
  late final List<Character> photos = [];

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 53, 53),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Resume",
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 53, 53, 53),
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
          aspectRatio: 1.5,
          viewportFraction: 0.9,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          initialPage: 2,
          autoPlay: true,
            ),
            items: imageSliders,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Radio(
                  value: 1,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value!;
                    });
                  }),
              const SizedBox(
                width: 10.0,
              ),
              const Text(
                "tatooine",
                style: TextStyle(color: Colors.grey),
              ),
              Radio(
                  value: 2,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value!;
                    });
                  }),
              const SizedBox(
                width: 10.0,
              ),
              const Text(
                "naboo",
                style: TextStyle(color: Colors.grey),
              ),
              Radio(
                  value: 3,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value!;
                    });
                  }),
              const SizedBox(
                width: 10.0,
              ),
              const Text(
                "kamino",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
                        const SizedBox(
                width: 30.0,
              ),
        Container(
          height: 300,
          width: 300,
        // padding: const EdgeInsets.fromLTRB(1.0, 10.0, 1.0, 10.0),
        child: FutureBuilder<List<Character>>(
          future: fetchPhotos(http.Client()),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? PhotosList(photos: snapshot.data!)
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
        ],
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Character> photos;
  PhotosList({required this.photos});

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(
                height: 150.0,
              ),
              color: const Color.fromARGB(255, 53, 53, 53),
              alignment: Alignment.center,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: Container(
                  height: 230.0,
                  width: 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                      image:  DecorationImage(
                          image: NetworkImage(photos[index].image),
                          fit: BoxFit.fill)),
                  child: Column(children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        photos[index].name,
                        style: const TextStyle(
                          fontSize: 23.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}