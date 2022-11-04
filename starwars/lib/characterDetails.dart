import 'package:flutter/material.dart';
import 'package:starwars/carousel.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'characterDetails.dart';

class Details extends StatefulWidget {
  late int id;
  late String name, image;
  late List<dynamic> affiliations;

  Details(this.id, this.name, this.image, this.affiliations, {super.key});

  @override
  State<Details> createState() => _DetailsState();
}

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

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    late String dropdownvalue = widget.affiliations.first;

    print(widget.name);
    print(this.widget.name);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 53, 53),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 53, 53, 53),
        centerTitle: true,
        title: Text(
          this.widget.name,
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        //padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Container(
                height: 250.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   begin: FractionalOffset.topLeft,
                    //   end: FractionalOffset.bottomRight,
                    //   colors: [
                    //     Color.fromARGB(255, 167, 14, 14).withOpacity(0.0),
                    //     Colors.black,
                    //   ],
                    // ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black,
                    image: DecorationImage(
                        image: NetworkImage(this.widget.image),
                        fit: BoxFit.fitWidth))),
            const SizedBox(
              height: 35,
            ),

            //character name
            Container(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: (Text(
                this.widget.name,
                style: const TextStyle(color: Colors.grey, fontSize: 20),
                textAlign: TextAlign.center,
                
                
              )),
            ),

            const SizedBox(
              height: 30,
            ),
            Container(
                //color: Colors.grey,
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        dropdownColor: Colors.grey,
                        value: dropdownvalue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.yellowAccent,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownvalue = value!;
                          });
                        },
                        items: widget.affiliations
                            .map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ])),
            const SizedBox(
              height: 230,
            ),
            ElevatedButton(
              //onHover: ,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 36, 36, 36), // background
                foregroundColor:
                    const Color.fromARGB(255, 110, 110, 110), // foreground
                //shadowColor: Colors.yellowAccent,
                // side: const BorderSide(
                //   color: Colors.white
                // ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 3,
                minimumSize: const Size(360, 55),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Carousel()));
              },
              child: const Text(
                'Resume',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
