import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reproductor_music/model/song_details.dart';
import 'package:reproductor_music/screen/audio_player_screen.dart';
import 'package:reproductor_music/widgets/neumorphic_button.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:reproductor_music/widgets/song_card.dart';
import 'dart:convert';

import '../colors.dart';


class SonList extends StatefulWidget {
  const SonList({Key? key}) : super(key: key);

  @override
  State<SonList> createState() => _SonListState();
}

class _SonListState extends State<SonList> {

  Future _getSongDetails() async{
    final jsonData =
    await rootBundle.rootBundle.loadString('assets/json/songs_detail.json');
    final sonList = json.decode(jsonData);
    return sonList.map((data) => SongDetails.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomButton(
                    primaryColor: primarybuttonColor,
                    secondaryColor: secondaryButtonColor,
                    padding: EdgeInsets.all(15),
                    child: Icon(
                      Icons.settings_rounded,
                      color: iconColor,
                    ),
                  ),
                  Text('Music Player',
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    )                  
                  ),
                  const CustomButton(
                    primaryColor: primarybuttonColor, 
                    secondaryColor: secondaryButtonColor,
                    padding: EdgeInsets.all(15),
                    child: Icon(
                      Icons.notifications_active_rounded,
                      color: iconColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: _getSongDetails(),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
                else if(snapshot.hasData){
                  var items = snapshot.data as List<dynamic>;
                  return Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int i){
                        final songs = items[i];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AudioPlayerScreen(
                                songDetails: songs,
                                ),
                                ),
                            ),
                            child: SongCard(
                              imageUrl: items[i].imageUrl,
                              songName: items[i].songName,
                              artistName: items[i].artistName,
                              songDuration: items[i].songDuration
                            ),
                          );                        
                      }, 
                      ),
                  );
                }else{
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
                },
            ),
          ],
        ),
      ),
    );
  }
}
              