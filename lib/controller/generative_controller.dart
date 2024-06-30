import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/controller/event.dart';

class GenerativeController extends Cubit<Event> {

  XFile? selectedPhoto;

  GenerativeController() : super(InitialState());

  void getCurrent({required String text, required String path}) async {
    emit(LoadingState());
    const String API_KEY = String.fromEnvironment(
        'gemini_key',
        defaultValue: '');
    final generativeConfig = GenerationConfig(
      temperature: 0.9,
      topP: 0.95,
      topK: 32,
      maxOutputTokens: 1024,
    );
    final _visionModel = GenerativeModel(
        model: 'gemini-1.0-pro-vision-latest',
        apiKey: API_KEY,
        generationConfig: generativeConfig
    );
    final content = [
      Content.multi([
        TextPart(text),
        DataPart('image/jpeg', File(path).readAsBytesSync())
      ])
    ];

    var response = await _visionModel.generateContent(content);
    emit(SuccessState(response.text ?? "Sem resultado!"));
  }

  void setSelectedPhoto(XFile newPhoto){
    selectedPhoto = newPhoto;
    emit(OnlyPhotoState());
  }

  void reset(){
    selectedPhoto = null;
    emit(InitialState());
  }

}