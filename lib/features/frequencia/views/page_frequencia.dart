import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/features/frequencia/provider/frequencia_provider.dart';
import 'package:flutter_app/features/frequencia/services/frequencia_services.dart';
import 'package:flutter_app/features/frequencia/widgets/container_frequencia.dart';
import 'package:flutter_app/features/frequencia/widgets/container_informations.dart';
import 'package:flutter_app/theme/custom_text_style.dart';
import 'package:flutter_app/widgets/customBackGroundLayout.dart';
import 'package:provider/provider.dart';

class PageFrequencia extends StatefulWidget {
  const PageFrequencia({super.key});

  @override
  State<PageFrequencia> createState() => _PageFrequenciaState();
}

class _PageFrequenciaState extends State<PageFrequencia> {
  FrequenciaServices frequenciaServices = FrequenciaServices();
  @override
  Widget build(BuildContext context) {
    final frequenciaProvider = context.watch<FrequenciaProvider>();
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Column(
        children: [
          SafeArea(
              child: ContainerInformations(
                  selectDate: frequenciaProvider.selecionarMes)),
          Flexible(
            child: CustomBackgroundLayout(
                child1: Container(),
                child2: frequenciaProvider.isLoading
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            Text(
                              'Carregando dados...',
                              style: CustomTextStyle.titleSmallLogin,
                            )
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Frequência de ${frequenciaProvider.mes}",
                                  style: CustomTextStyle.headlineSmallWhiteA700,
                                ),
                                Text(
                                  "6° ano A matutino",
                                  style: CustomTextStyle.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      height: 2,
                                    ),
                                itemCount: frequenciaProvider.alunos.length,
                                itemBuilder: (context, index) {
                                  List list = frequenciaProvider.alunos;
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${frequenciaProvider.alunos[index]['nome']}',
                                            style:
                                                CustomTextStyle.titleSmallLogin,
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                              children: List.generate(
                                                  list[index]['frequencia']
                                                          ['dias']
                                                      .length, (indice) {
                                            String diaDaSemana = list[index]
                                                    ['frequencia']['dias']
                                                [indice]['diaDaSemana'];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 5.0),
                                                          child: Text(list[index]
                                                                          [
                                                                          'frequencia']
                                                                      ['dias'][
                                                                  indice]['dia']
                                                              .toString()),
                                                        ),
                                                        Text(diaDaSemana
                                                            .substring(0, 3)),
                                                      ],
                                                    ),
                                                  ),
                                                  ContainerFrequencia(
                                                    indexAluno: index,
                                                    indexValorFrequencia:
                                                        indice,
                                                    value: list[index]
                                                                ['frequencia']
                                                            ['dias'][indice]
                                                        ['falta'],
                                                  ),
                                                ],
                                              ),
                                            );
                                          })),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                child3: Container(),
                heightContainer: 0.85),
          ),
        ],
      ),
    ));
  }
}
