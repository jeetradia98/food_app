import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_app/blocs/auth/auth_bloc.dart';
import 'package:food_app/database/db_repo.dart';
import 'package:food_app/utils/base_colors.dart';
import 'package:food_app/utils/preference_manager.dart';
import 'package:food_app/utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final PreferenceManager preferenceManager = PreferenceManager();

  List list = await Future.wait([
    AppDB.instance.openDB(),
    preferenceManager.readUser,
  ]);

  final bool? value = list[1];

  runApp(MyApp(isLogin: value ?? false));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isLogin}) : super(key: key);

  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        // BlocProvider(create: (context) => CategoryBloc()),
        // BlocProvider(create: (context) => OrderBlocCubit()),
        // BlocProvider(create: (context) => ItemsBloc()),
        // BlocProvider(create: (context) => ScreenSaverCubit()),
      ],
      child: ScreenUtilInit(
        builder: (c) => GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: GetMaterialApp(
            title: 'Food_app',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: BaseColors.white,
            ),
            initialRoute: isLogin ? Routes.login : Routes.home,
            onGenerateRoute: Routes.generateRoute,
          ),
        ),
      ),
    );
  }
}
