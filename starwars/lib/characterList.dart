import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'characterDetails.dart';

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
  //final int died;
  var affiliations = [];

  Character({
    required this.id,
    required this.name,
    required this.image,
    required this.wiki,
    //required this.died,
    required this.affiliations,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      wiki: json['wiki'] as String,
      affiliations: json['affiliations'] as List,
      // died: json['died'] as int,
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 53, 53),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Characters List",
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 44, 44, 44),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(1.0, 10.0, 1.0, 10.0),
        child: FutureBuilder<List<Character>>(
          future: fetchPhotos(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? PhotosList(photos: snapshot.data!)
                : const Center(child: CircularProgressIndicator());
          },
        ),
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
                height: 250.0,
              ),
              color: const Color.fromARGB(255, 53, 53, 53),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Details(
                            photos[index].id,
                            photos[index].name,
                            photos[index].image,
                            photos[index].affiliations,
                          )));
                },
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
                        image: DecorationImage(
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
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      //Description web scraper
                      const Center(
                        child: Text(
                          'DESCRIPTION DE CHARACTER',
                          //photos[index].name,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      //date
                    ]),
                  ),
                ),
              ),
              //  Card(
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: <Widget>[

              //       ListTile(

              //         leading: Image.network(
              //           photos[index].image,
              //           fit: BoxFit.fitWidth,
              //         ),
              //         title: Text(photos[index].name),
              //         subtitle: Text(photos[index].name),
              //       ),
              //     ],
              //   ),
              // )
            ),
          ],
        );
      },
    );
  }
}
