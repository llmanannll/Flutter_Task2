import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;
  String? _filePath;
  double _currentPosition = 0;
  double _totalDuration = 0;

  @override
  void dispose() {
    _audioPlayer.dispose();
    _recorder.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    final bool isPermissionGranted = await _recorder.hasPermission();
    if (!isPermissionGranted) {
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    // Generate a unique file name using the current timestamp
    String fileName = 'recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
    _filePath = '${directory.path}/$fileName';

    // Define the configuration for the recording
    const config = RecordConfig(
      // Specify the format, encoder, sample rate, etc., as needed
      encoder: AudioEncoder.aacLc, // For example, using AAC codec
      sampleRate: 44100, // Sample rate
      bitRate: 128000, // Bit rate
    );

    // Start recording to file with the specified configuration
    await _recorder.start(config, path: _filePath!);
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    final path = await _recorder.stop();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _playRecording() async {
    if (_filePath != null) {
      await _audioPlayer.setFilePath(_filePath!);
      _totalDuration = _audioPlayer.duration?.inSeconds.toDouble() ?? 0;
      _audioPlayer.play();

      _audioPlayer.positionStream.listen((position) {
        setState(() {
          _currentPosition = position.inSeconds.toDouble();
        });
      });
    }
  }

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
              SizedBox(
                height: 5,
              ),
              Text(
                "What is your favorite time of the day?",
                textAlign: TextAlign.center,
                style: GoogleFonts.figtree(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '"Mine is definitely the peace in the morning."',
                style: GoogleFonts.figtree(
                    fontSize: 13,
                    color: Color.fromARGB(197, 203, 201, 255),
                    fontStyle: FontStyle.italic),
              ),
              Slider(
                value: _currentPosition,
                max: _totalDuration,
                onChanged: (value) {
                  setState(() {
                    _currentPosition = value;
                  });
                  _audioPlayer.seek(Duration(seconds: value.toInt()));
                },
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
                    onPressed: _isRecording ? _stopRecording : null,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    height: 52,
                    width: 52,
                    child: IconButton(
                      onPressed: _isRecording ? null : _startRecording,
                      icon: Icon(
                        _isRecording ? Icons.mic : Icons.mic_none,
                        size: 20,
                        color: _isRecording ? Colors.red : Colors.blue,
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Submit",
                      style: GoogleFonts.figtree(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 13),
                    ),
                    onPressed: !_isRecording ? _playRecording : null,
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
