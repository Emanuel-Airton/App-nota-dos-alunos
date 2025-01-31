import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/features/alunos/models/alunos_models.dart';
import 'package:flutter_app/models/model_disciplina.dart';

class ContainerNomeAluno extends StatelessWidget {
  final Alunos alunos;
  final Disciplina disciplina;

  const ContainerNomeAluno({
    super.key,
    required this.alunos,
    required this.disciplina,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
      child: Container(
        height: mediaQuery.size.height * 0.12,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 3),
          /*  boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3),
              blurRadius: 3,
            ),
          ],*/
        ),
        child: Row(
          children: [
            _buildImageSection(mediaQuery),
            const SizedBox(width: 10),
            _buildInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(MediaQueryData mediaQuery) {
    return Container(
      width: mediaQuery.size.width * 0.25,
      height: mediaQuery.size.height * 0.12,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/student.png',
          height: mediaQuery.size.height * 0.1,
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          alunos.nomeAluno ?? 'Aluno',
          style: CustomTextStyle.fontInfoAlunoWhite,
        ),
        const SizedBox(height: 5),
        Text(
          '6º ano A matutino',
          style: CustomTextStyle.fontInfoAlunoWhite,
        ),
        const SizedBox(height: 5),
        Text(
          disciplina.nomeDisciplina ?? 'Disciplina',
          style: CustomTextStyle.fontInfoAlunoWhite,
        ),
      ],
    );
  }
}
