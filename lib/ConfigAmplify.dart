import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:fincept1/amplifyconfiguration.dart';
import 'dart:async';

// Future<void> configureAmplify() async {
//   try {
//     final auth = AmplifyAuthCognito();
//     var isSignedIn = false;
//
//     subscription = Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
//       setState(() {
//         lastHubEvent = hubEvent.eventName;
//       });
//       if (lastHubEvent != 'SIGNED_IN') {
//         changeDisplay('SHOW_SIGN_IN');
//       }
//       print('HUB: $lastHubEvent');
//     });
//
//     await Amplify.addPlugin(auth);
//     //final datastorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);
//     //await Amplify.addPlugin(datastorePlugin);
//     await Amplify.configure(amplifyconfig);
//
//     // call Amplify.configure to use the initialized categories in your app
//     await Amplify.configure(amplifyconfig);
//   } on Exception catch (e) {
//     print('An error occurred configuring Amplify: $e');
//     print('Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
//   }
// }