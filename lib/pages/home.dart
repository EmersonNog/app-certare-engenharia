import 'package:certare_app/pages/pdf_page.dart';
import 'package:certare_app/widgets/auth_button.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Image.asset('assets/images/certare.png'),
          title: const Text(
            'Grupo Certare - Teresina',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0x00F44336),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.6,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.6,
              decoration: const BoxDecoration(
                  color: Color(0xFF674AEF),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(70))),
              child: Center(
                child: Image.asset(
                  'assets/images/certare.png',
                  scale: 0.8,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.666,
                decoration: BoxDecoration(
                  color: Color(0xFF674AEF),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.666,
                padding: EdgeInsets.only(top: 40, bottom: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(70))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: textTheme.headlineSmall,
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'O ',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              )),
                          TextSpan(
                            text: 'GRUPO ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 129, 6, 1),
                                fontFamily: 'Prototype'),
                          ),
                          TextSpan(
                            text: 'CERTARE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(244, 67, 54, 1),
                              fontFamily: 'Prototype',
                            ),
                          ),
                          TextSpan(
                              text:
                                  ' É REFERÊNCIA EM CONSULTORIA, PROJETOS E EXECUÇÃO',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Material(
                      color: Color(0xFF674AEF),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PdfPage()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 80),
                          child: Text(
                            "Criar Laudo",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
