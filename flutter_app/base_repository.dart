import 'package:flutter/services.dart';
import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import '../api/auth.dart';

class BaseRepository {
  static BaseRepository? _instance;
  static BaseRepository get instance =>
      _instance ??= BaseRepository();

  late DialogflowGrpcV2Beta1 _dialogflow;
  Stream<StreamingDetectIntentResponse>? responseStream;
  late InputConfigV2beta1 dfAudioConfig;

  Future<void> ensureInitialize() async {
    final serviceAccount = ServiceAccount.fromString(
      await rootBundle.loadString('assets/credentials.json'),
    );

    _dialogflow =
        DialogflowGrpcV2Beta1.viaServiceAccount(serviceAccount);

    BotAuthentication.initialize();

    var biasList = SpeechContextV2Beta1(
      phrases: ['Dialogflow CX', 'Action Builder', 'HIPAA'],
      boost: 20.0,
    );

    dfAudioConfig = InputConfigV2beta1(
      encoding: 'AUDIO_ENCODING_LINEAR_16',
      languageCode: 'en-US',
      sampleRateHertz: 16000,
      singleUtterance: false,
      speechContexts: [biasList],
    );
  }

  Future<QueryResult> detectTextIntent(String text) async {
    final data = await _dialogflow.detectIntent(text, 'en-US');
    return data.queryResult;
  }
}
