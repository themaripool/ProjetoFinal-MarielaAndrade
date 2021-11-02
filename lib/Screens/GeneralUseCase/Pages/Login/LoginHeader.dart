
/*
  LoginHeader: Header e fundo da tela
*/

import '../../GeneralUseCase.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 230,
          color: Colors.grey[850],
          child: Padding(
            padding: const EdgeInsets.only(top: 130),
            child: Column(
              children: [
                Text(
                  "Monitoramento",
                  style: TextStyle(color: Colors.white, fontSize: 36),
                ),
                Text("COVID",
                    style: TextStyle(color: Colors.white, fontSize: 36)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}