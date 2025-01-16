import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({super.key});

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(200, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.44,
                    height: 3,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(88, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.44,
                    height: 3,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 17,
                    ),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                  Text(
                    "Angelina, 28",
                    style: GoogleFonts.figtree(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.menu_sharp,
                      size: 17,
                    ),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: const Color.fromARGB(255, 18, 21, 23),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage("assets/person.jpg"),
                ),
              ),
              Container(
                width: 110,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 18, 21, 23),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: Text(
                    "Stroll Question",
                    style: GoogleFonts.figtree(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Text(
                "What is your favorite time of the day?",
                textAlign: TextAlign.center,
                style: GoogleFonts.figtree(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),

              //Here the wave of recoding
              //
              //
              //
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text(
                      "Delete",
                      style: GoogleFonts.figtree(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 13),
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.amber),
                    height: 52,
                    width: 52,
                  ),
                  TextButton(
                    child: Text(
                      "Submit",
                      style: GoogleFonts.figtree(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 13),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Unmatch",
                style: GoogleFonts.figtree(color: Colors.red, fontSize: 13),
              ),
              SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
