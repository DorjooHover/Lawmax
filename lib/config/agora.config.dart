String get appId {
  return const String.fromEnvironment('AGORA_APP_ID',
      defaultValue: 'a941d13a5641456b95014aa4fc703f70');
}
String get baseUrl {
  return const String.fromEnvironment('BASE_URL',
      defaultValue: 'https://lawyernestjs-production.up.railway.app');
}
String get agoraUrl {
  return const String.fromEnvironment('AGORA_URL',
      defaultValue: 'https://agora-token-service-production-3c76.up.railway.app/rtc');
}
String get googleMap {
  return const String.fromEnvironment('GOOGLE_MAP',
      defaultValue: 'AIzaSyBfIRFXoIgr-h4EDa-MK0S1rs1BViwMP_Y');
}
