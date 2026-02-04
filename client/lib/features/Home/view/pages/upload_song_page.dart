import 'dart:io' show File;
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/core/theme/app_pallet.dart';
import 'package:music_player/core/utils.dart';
import 'package:music_player/features/Home/view/widgets/audio_wave.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final _songNameController = TextEditingController();
  final _artistNameController = TextEditingController();
  Color selectedColor = Pallete.gradient1;
  File? selectedImage;
  File? selectedAudio;

  void selectImage() async {
    HapticFeedback.lightImpact();
    final pickedImage = await imagePicker();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  void selectAudio() async {
    HapticFeedback.lightImpact();
    final pickedAudio = await audioPicker();
    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  @override
  void dispose() {
    _songNameController.dispose();
    _artistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              HapticFeedback.lightImpact();
            },
            icon: const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Icon(Icons.check_circle_rounded, size: 30),
            ),
          ),
        ],
        title: const Text(
          'Upload Song',
          style: TextStyle(
            color: Pallete.whiteColor,
            fontWeight: FontWeight.w400,
            fontFamily: 'Zain',
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: selectedColor != Pallete.gradient1
                ? [selectedColor, Colors.black54]
                : [Colors.grey.shade800, Colors.black12, Colors.black54],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: selectImage,
                      child: selectedImage != null
                          ? SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : const DottedBorder(
                              options: RoundedRectDottedBorderOptions(
                                radius: Radius.circular(10),
                                strokeCap: StrokeCap.round,
                                color: Pallete.geryGradiant2,
                                dashPattern: [10, 3],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.folder_open, size: 40),
                                    SizedBox(height: 10),
                                    Text(
                                      'Select the thumbnail for your song',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Zain',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  selectedAudio != null
                      ? AudioWave(
                          path: selectedAudio!.path,
                          liveColor: selectedColor,
                        )
                      : TextField(
                          onTap: selectAudio,
                          decoration: InputDecoration(
                            hintText: 'Pick Song',
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Pallete.whiteColor,
                              fontFamily: 'Zain',
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Pallete.geryGradiant2,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: _songNameController,
                    decoration: InputDecoration(
                      hintText: 'Song Name',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Pallete.whiteColor,
                        fontFamily: 'Zain',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Pallete.geryGradiant2,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: _artistNameController,
                    decoration: InputDecoration(
                      hintText: 'Artist Name',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Pallete.whiteColor,
                        fontFamily: 'Zain',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Pallete.geryGradiant2,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ColorPicker(
                    color: selectedColor,
                    pickersEnabled: const {ColorPickerType.wheel: true},
                    onColorChanged: (Color color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
