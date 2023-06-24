import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// Future<Photo> fetchPhoto() async {
//   final response = await http
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/photos/1'));
//   if (response.statusCode == 200) {
//     return Photo.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
class Display {
  final int id;
  final String title;
  // final String url;
  final String thumbnailUrl;

  Display({
    required this.id,
    required this.title,
    // required this.url,
    required this.thumbnailUrl,
  });

  factory Display.fromJson(Map<String, dynamic> json) {
    return Display(
      id: json['id'],
      title: json['title'],
      // url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}

class AddCommentScreen extends StatefulWidget {
  const AddCommentScreen({Key? key}) : super(key: key);

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  final commentController = TextEditingController();
  int _currentIndex = 0;

  List<Display> postList = [];

  Future<Object> getApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (Map i in data) {
        postList.add(Display.fromJson(Map<String, dynamic>.from(i)));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Column(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('card.png'),
                    fit: BoxFit.fill,
                  ),
                  color: Color.fromARGB(246, 249, 255, 255),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // color: Color.fromARGB(255, 245, 244, 245),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Add Comments',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3,
              ),

              //  This is a Filter Search
              Padding(
                padding: EdgeInsets.all(12.0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 245, 244, 245),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black45),
                    ),
                    hintText: "Search",
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30.0,
                    ),
                  ),
                  onTap: () {},
                ),
              ),

              // This is fetch data show screen used circle avater and tiitle and icon button
              Padding(
                padding: EdgeInsets.all(12.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.black45,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Color.fromARGB(255, 245, 244, 245),
                  textColor: Colors.black,
                  iconColor: Colors.black45,
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 16,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 245, 244, 245),
                      radius: 14,
                      child: Text(
                        'ONE',
                        // items[index],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // ),
                    ),
                  ),
                  title: Text(
                    'This is the first comment.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  trailing: SizedBox(
                    width: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.add_outlined,
                      ),
                      onPressed: () => {
                        openDialog(),
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: getApi(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Colors.black45,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Color.fromARGB(255, 245, 244, 245),
                        textColor: Colors.black,
                        iconColor: Colors.black45,
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              child: Image.network(
                                postList[index].thumbnailUrl.toString(),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          postList[index].title.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        trailing: SizedBox(
                          width: 30,
                          child: Icon(
                            Icons.check,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      //  This is Nav bar Button
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(13),
          topLeft: Radius.circular(13),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Color.fromARGB(255, 245, 244, 245),
          // backgroundColor: Color.fromARGB(249, 250, 255, 255),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              // title: Text('Home'),
              label: 'Home',
              backgroundColor: Colors.deepPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              // title: Text('Add Card'),
              label: 'Add Card',
              backgroundColor: Colors.deepPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper_rounded),
              // title: Text('News'),
              label: 'News',
              backgroundColor: Colors.deepPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded),
              // title: Text('Profile'),
              label: 'Profile',
              // LabelStyle: TextStyle(fontWeight: FontWeight.bold),
              backgroundColor: Colors.deepPurple,
            ),
          ],
          selectedItemColor: Colors.deepPurple,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Type below',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          content: TextFormField(
            controller: commentController,
            decoration: InputDecoration(
              hintText: 'Comment',
              filled: true,
              fillColor: Color.fromARGB(255, 245, 244, 245),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Add();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(18),
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
  // ignore: non_constant_identifier_names
  void Add() {
    saveComment();
    Navigator.of(context).pop(Add);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 2000),
        backgroundColor: Colors.black,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'New Comment was addedd!',
              style: TextStyle(color: Colors.white),
            ),
            // Icon(
            //   Icons.check_circle_outline,
            //   size: 20,
            // ),
          ],
        ),
      ),
    );
  }

  saveComment() async {
    var headers = {
      "Accept": "application/json",
      "Content-type": "application/json"
    };
    final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/photos/1'),
        headers: headers,
        body: json.encode({
          'id': '1',
          'title': commentController.text.toString(),
          'thumbnailUrl': 'https://google.com'
        }));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }
}
