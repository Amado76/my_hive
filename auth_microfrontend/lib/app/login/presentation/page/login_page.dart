import 'package:common_microfrontend/util/theme_and_colors/domain/util/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:auth_microfrontend/app/core/data/dto/auth_config_dto.dart';
import 'package:auth_microfrontend/app/login/presentation/bloc/login_bloc.dart';
import 'package:auth_microfrontend/app/login/presentation/components/login_form.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class LoginPage extends StatefulWidget {
  final AuthConfigDto authConfigDto;
  final String homeUrl;

  const LoginPage({
    super.key,
    required this.authConfigDto,
    required this.homeUrl,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = Modular.get<LoginBloc>();
    final Translation translation = Modular.get<Translation>();
    final NavigationInjector navigator = Modular.get<NavigationInjector>();
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/background.png"),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocListener<LoginBloc, LoginState>(
              bloc: loginBloc,
              listener: (context, state) {
                switch (state) {
                  case LoginIdle():
                  case LoginLoading():
                    break;
                  case LoginError():
                    showErrorDialog(
                      context: context,
                      title: state.authError.dialogTitle,
                      contentText: state.authError.dialogText,
                    );

                    break;
                  case LoginSuccess():
                    Modular.to.navigate(
                      navigator.getPath(
                        package: 'baseapp',
                        pathKey: 'root',
                      ),
                    );
                }
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 35),
                    child: SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.3,
                            child: Image.asset("assets/images/logo.png",
                                alignment: Alignment.center),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translation.translate(
                                package: 'authentication', key: 'loginWelcome'),
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(HexColor.intFromHex('#b27d00'))),
                          ),
                          const SizedBox(height: 30),
                          LoginForm(
                            authConfigDto: widget.authConfigDto,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
