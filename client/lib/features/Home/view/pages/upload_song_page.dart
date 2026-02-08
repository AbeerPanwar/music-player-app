import 'dart:io' show File;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:music_player/core/theme/app_pallet.dart';
import 'package:music_player/core/utils.dart';
import 'package:music_player/core/widgets/loader.dart';
import 'package:music_player/features/Home/view/pages/home_screen.dart';
import 'package:music_player/features/Home/view/widgets/audio_wave.dart';
import 'package:music_player/features/Home/viewmodel/home_viewmodel.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final _songNameController = TextEditingController();
  final _artistNameController = TextEditingController();
  Color selectedColor = Pallete.geryGradiant2;
  File? selectedImage;
  File? selectedAudio;
  final formKey = GlobalKey<FormState>();

  void changeColor(Color color) {
    setState(() => selectedColor = color);
  }

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
    final isLoading = ref.watch(
      homeViewModelProvider.select((val) => val?.isLoading == true),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              HapticFeedback.lightImpact();
              if (formKey.currentState!.validate() &&
                  selectedAudio != null &&
                  selectedImage != null) {
                ref
                    .read(homeViewModelProvider.notifier)
                    .uploadSong(
                      selectedAudio: selectedAudio!,
                      selectedThumbnail: selectedImage!,
                      songName: _songNameController.text.trim(),
                      artist: _artistNameController.text.trim(),
                      selectedColor: selectedColor,
                    );
                Navigator.pop(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HomeScreen(),
                  ),
                );
              } else {
                showSnackbar(context, 'Missing Fields !!');
              }
            },
            icon: const LiquidGlassLayer(
              child: LiquidStretch(
                child: LiquidGlass(
                  shape: LiquidRoundedSuperellipse(borderRadius: 25),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_rounded,
                      size: 25,
                      color: Pallete.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        title: const LiquidGlassLayer(
          child: LiquidStretch(
            child: LiquidGlass(
              shape: LiquidRoundedSuperellipse(borderRadius: 20),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Upload Song',
                  style: TextStyle(
                    color: Pallete.whiteColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Zain',
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: selectedColor != Pallete.geryGradiant2
                ? [selectedColor, Colors.black54]
                : [Colors.grey.shade800, Colors.black54],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? Loader(
                color: darken(selectedColor, 0.2),
                backgroundColor: lighten(selectedColor, 0.2),
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: selectImage,
                            child: selectedImage != null
                                ? LiquidGlassLayer(
                                    child: LiquidGlass(
                                      shape: const LiquidRoundedRectangle(
                                        borderRadius: 10,
                                      ),
                                      child: SizedBox(
                                        height: 150,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Image.file(
                                            selectedImage!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const LiquidGlassLayer(
                                    child: LiquidGlass(
                                      shape: LiquidRoundedRectangle(
                                        borderRadius: 10,
                                      ),
                                      child: DottedBorder(
                                        options: RoundedRectDottedBorderOptions(
                                          radius: Radius.circular(10),
                                          strokeCap: StrokeCap.round,
                                          color: Pallete.geryGradiant2,
                                          dashPattern: [6, 6],
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                          ),
                        ),
                        const SizedBox(height: 40),
                        selectedAudio != null
                            ? LiquidGlassLayer(
                                child: LiquidGlass(
                                  shape: const LiquidRoundedSuperellipse(
                                    borderRadius: 28,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: AudioWave(
                                      path: selectedAudio!.path,
                                      liveColor: selectedColor,
                                    ),
                                  ),
                                ),
                              )
                            : LiquidGlassLayer(
                                child: LiquidGlass(
                                  shape: const LiquidRoundedSuperellipse(
                                    borderRadius: 12,
                                  ),
                                  child: TextField(
                                    readOnly: true,
                                    onTap: selectAudio,
                                    decoration: InputDecoration(
                                      hintText: 'Pick Song',
                                      hintStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Pallete.whiteColor,
                                        fontFamily: 'Zain',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: lighten(selectedColor, 0.2),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 25),
                        LiquidGlassLayer(
                          child: LiquidGlass(
                            shape: const LiquidRoundedSuperellipse(
                              borderRadius: 12,
                            ),
                            child: TextFormField(
                              controller: _songNameController,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Song Name is missing';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Song Name',
                                hintStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Pallete.whiteColor,
                                  fontFamily: 'Zain',
                                  fontWeight: FontWeight.w400,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: lighten(selectedColor, 0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: darken(selectedColor, 0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: darken(selectedColor, 0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: darken(selectedColor, 0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        LiquidGlassLayer(
                          child: LiquidGlass(
                            shape: const LiquidRoundedSuperellipse(
                              borderRadius: 12,
                            ),
                            child: TextFormField(
                              controller: _artistNameController,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Artist name is missing';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Artist Name',
                                hintStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Pallete.whiteColor,
                                  fontFamily: 'Zain',
                                  fontWeight: FontWeight.w400,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: lighten(selectedColor, 0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: darken(selectedColor, 0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: darken(selectedColor, 0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: darken(selectedColor, 0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        LiquidGlassLayer(
                          child: LiquidGlass(
                            shape: const LiquidRoundedSuperellipse(
                              borderRadius: 16,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.selectionClick();
                                showGeneralDialog(
                                  context: context,
                                  transitionDuration: const Duration(
                                    milliseconds: 250,
                                  ),
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                        return Center(
                                          child: LiquidGlassLayer(
                                            child: LiquidGlass(
                                              shape:
                                                  const LiquidRoundedSuperellipse(
                                                    borderRadius: 12,
                                                  ),
                                              child: SizedBox(
                                                width: 350,
                                                height: 550,
                                                child: AlertDialog(
                                                  backgroundColor:
                                                      Pallete.transparentColor,
                                                  title: const Text(
                                                    'Pick a Color',
                                                    style: TextStyle(
                                                      fontFamily: 'Zain',
                                                    ),
                                                  ),
                                                  content: ColorPicker(
                                                    pickerColor: selectedColor,
                                                    pickerAreaHeightPercent:
                                                        0.8,
                                                    labelTypes: const [],
                                                    pickerAreaBorderRadius:
                                                        BorderRadius.circular(
                                                          50,
                                                        ),
                                                    onColorChanged: changeColor,
                                                  ),
                                                  actions: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        HapticFeedback.selectionClick();
                                                        Navigator.of(
                                                          context,
                                                        ).pop();
                                                      },
                                                      child: const Text(
                                                        'Got It',
                                                        style: TextStyle(
                                                          fontFamily: 'Zain,',
                                                          fontSize: 18,
                                                          color: Pallete
                                                              .whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                  transitionBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) {
                                        final slideAnimation =
                                            Tween<Offset>(
                                              begin: const Offset(0, 1),
                                              end: Offset.zero,
                                            ).animate(
                                              CurvedAnimation(
                                                parent: animation,
                                                curve: Curves.easeOutCubic,
                                                reverseCurve:
                                                    Curves.easeInCubic,
                                              ),
                                            );

                                        return SlideTransition(
                                          position: slideAnimation,
                                          child: FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          ),
                                        );
                                      },
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'Pick Color',
                                  style: TextStyle(
                                    fontFamily: 'Zain,',
                                    color: Pallete.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
