import 'package:flutter/material.dart';
import 'package:flutter_app/theme/custom_text_style.dart';
import 'package:flutter_app/widgets/customBackGroundLayout.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_app/core/app_export.dart';

class HorarioView extends StatefulWidget {
  const HorarioView({super.key});

  @override
  State<HorarioView> createState() => _HorarioViewState();
}

class _HorarioViewState extends State<HorarioView> {
  List<Map<String, dynamic>> list = [
    {
      'horario': '08:00 - 08:45',
      'disciplina': 'Geografia',
      'turma': '8º A matutino',
      'sala': 2
    },
    {
      'horario': '08:45 - 09:30',
      'disciplina': 'Geografia',
      'turma': '9º A matutino',
      'sala': 4
    },
    {
      'horario': '09:30 - 10:15',
      'disciplina': 'Geografia',
      'turma': '9º A matutino',
      'sala': 4
    },
    {
      'horario': '10:30 - 11:15',
      'disciplina': 'Geografia',
      'turma': '7º A matutino',
      'sala': 1
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        CustomBackgroundLayout(
          child1: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Seu Horario de aula',
                    style: CustomTextStyle.titleLargeWhite,
                  ),
                ),
              )),
          child2: Column(children: [
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  String horario = list[index]['horario'] ?? '';
                  String turma = list[index]['turma'] ?? '';
                  String disciplina = list[index]['disciplina'] ?? '';
                  int sala = list[index]['sala'] ?? 0;
                  return Column(
                    children: [
                      TimelineTile(
                        beforeLineStyle: LineStyle(
                          color: Theme.of(context).colorScheme.errorContainer,
                          thickness: 5,
                        ),
                        indicatorStyle: IndicatorStyle(
                          indicatorXY: 0.1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        alignment: TimelineAlign.manual,
                        lineXY: 0.1,
                        endChild: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                // width: MediaQuery.of(context).size.width * 0.05,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        horario,
                                        style: CustomTextStyle.bodySmallHorario,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                bottom: 30,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 3,
                                          offset: Offset(0, 3),
                                          color: Colors.grey)
                                    ],
                                    color: const Color(0xFFEFEFEF),
                                    borderRadius: BorderRadius.circular(15)),
                                constraints: const BoxConstraints(
                                  minHeight: 100,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          turma,
                                          style:
                                              CustomTextStyle.fontTurmaHorario,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/book.png',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                disciplina,
                                                style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text('sala ${sala.toString()}',
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 16))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ]),
          //child3: Container(),

          child3: Container(),
          heightContainer: 0.70,
        ),
        Align(
          alignment: const Alignment(0, -0.6),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    blurRadius: 3, offset: Offset(0, 3), color: Colors.grey)
              ],
              color: const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('SEG'),
                ),
                TextButton(onPressed: () {}, child: const Text('TER')),
                TextButton(onPressed: () {}, child: const Text('QUA')),
                TextButton(onPressed: () {}, child: const Text('QUI')),
                TextButton(onPressed: () {}, child: const Text('SEX')),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
