import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' show PdfImage;

final List<String?> photoPaths = [];

void resetPhotoPaths() {
  photoPaths.clear();
}

// Função para capturar as fotos e retornar o caminho do arquivo
Future<void> capturePhotos(int desiredCount) async {
  final imagePicker = ImagePicker();

  // Calcular o número de fotos restantes para capturar
  int remainingCount = desiredCount - photoPaths.length;
  if (remainingCount <= 0) return;

  // Capturar fotos restantes
  for (int i = 0; i < remainingCount; i++) {
    final imageFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (imageFile == null) break;
    photoPaths.add(imageFile.path);
  }
}

// Função para adicionar uma foto ao documento PDF
Future<void> addPhotoToPdf(pw.Document doc, String? imagePath) async {
  if (imagePath == null) return;
  final file = File(imagePath);
  if (!file.existsSync()) return;

  final Uint8List bytes = file.readAsBytesSync();
  final pdfImage = pw.MemoryImage(bytes);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pw.PageTheme(
        margin: pw.EdgeInsets.symmetric(
            horizontal: 1 * PdfPageFormat.cm, vertical: 1 * PdfPageFormat.cm),
        textDirection: pw.TextDirection.ltr,
        orientation: pw.PageOrientation.portrait,
      ),
      header: (final context) =>
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
        pw.Container(
          alignment: pw.Alignment.center,
          color: PdfColor.fromHex('#649c7f'),
          height: 30,
          width: 400,
          child: pw.Text("ANEXO A RELATÓRIO FOTOGRÁFICO",
              style: pw.TextStyle(
                  fontSize: 15,
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold)),
        ),
      ]),
      footer: (final context) => pw.Row(children: [
        pw.Container(
          alignment: pw.Alignment.center,
          color: PdfColor.fromHex('#649c7f'),
          width: 700,
          child: pw.Text("www.certare.com",
              style: pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold)),
          margin: const pw.EdgeInsets.fromLTRB(-75, 0, 0, -30),
        )
      ]),
      build: (pw.Context context) {
        return [
          pw.Container(
            alignment: pw.Alignment.topCenter,
            child: pw.Column(
              children: [
                pw.SizedBox(height: 20),
                pw.Container(
                  child: pw.Image(pdfImage, height: 300),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                    alignment: pw.Alignment.topLeft,
                    color: PdfColor.fromHex('#e4e4e4'),
                    width: 300,
                    height: 100,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text("  DESCRIÇÃO:\n",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(height: 20),
                          pw.Text("AMBIENTE:\n",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ])),
              ],
            ),
          ),
        ];
      },
    ),
  );
}

Future<Uint8List> generatePdf(
  final PdfPageFormat format,
  String cod,
  //form 1
  String name_entrevistado,
  String cpf_entrevistado,
  String name_proprietario,
  String cpf_proprietario,
  String contato,
  String endereco,
  String cidade,
  String bairro,
  String moradores,
  String situacao,
  String construcao,
  String ocupacao,
  //form 2
  String tipoImovel,
  String pavimento,
  String muro,
  String padraoConstrutivo,
  String idadeAparente,
  String aberto,
  String qtdQuarto,
  String qtdBanheiro,
  String qtdSuite,
  String garagem,
  String situacaoArea,
  //form 3
  String tipologiaPiso,
  String patologiaPiso,
  String tipoPatologiaPiso,
  //form 4
  String posivelIdentificar,
  String conservacao,
  String patologiaSuperestrutura,
  String elemento,
  String tipoPatologiaSuperestrutura,
  //form 5
  String itensTipologiaEdi,
  String revestimento,
  String itensRevestimento,
  String patologiaEdi,
  String tipoPatologiaEdi,
  String comodo,
  //form 6
  String tipologiaForro,
  String peSolto,
  String patologiaForro,
  String tipoPatologiaForro,
  //form 7
  String laje,
  String teto,
  String coleta,
  String tipologiaTelha,
  String patologiaTelha,
  String tipoPatologiaTelha,
  //form 8
  String resumo,
  String nomeCompleto,
  String cargo,
  String rg,
  String cpf,
) async {
  final doc = pw.Document(
    title: '$cod',
  );

  final footerImage = pw.MemoryImage(
    (await rootBundle.load('assets/images/footer.png')).buffer.asUint8List(),
  );

  final font = await rootBundle.load('assets/fonts/Prototype.ttf');
  final ttf = pw.Font.ttf(font);

  final pageTheme = await _myPageTheme(format);

  const smallTextStyle = pw.TextStyle(
    fontSize: 10,
  );
  const titleTextStyle = pw.TextStyle(fontSize: 10, color: PdfColors.white);
  var titleTextStyleTable = pw.TextStyle(
    fontSize: 9,
    color: PdfColors.black,
    fontWeight: pw.FontWeight.bold,
  );

  doc.addPage(pw.MultiPage(
      pageTheme: pageTheme,
      header: (final context) =>
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              color: PdfColor.fromHex('#649c7f'),
              height: 30,
              width: 400,
              child: pw.Text("LAUDO CAUTELAR DE VISTORIA DE VIZINHANÇA",
                  style: pw.TextStyle(
                      fontSize: 15,
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold)),
              margin: const pw.EdgeInsets.fromLTRB(0, -15, 0, 20),
              padding: const pw.EdgeInsets.only(left: 10),
            ),
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              color: PdfColor.fromHex('#649c7f'),
              height: 30,
              width: 115,
              child: pw.Text("CÓD.: $cod",
                  style: pw.TextStyle(
                      fontSize: 15,
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold)),
              margin: const pw.EdgeInsets.fromLTRB(5, -15, 0, 20),
              padding: const pw.EdgeInsets.only(left: 10),
            ),
          ]),
      footer: (context) => pw.Padding(
            padding: pw.EdgeInsets.only(bottom: -28, left: -33),
            child: pw.Container(
              child: pw.Image(
                alignment: pw.Alignment.topLeft,
                footerImage,
                fit: pw.BoxFit.contain,
                width: 600,
                height: 25,
              ),
            ),
          ),
      build: (final context) => [
            pw.Table(
              tableWidth: pw.TableWidth.max,
              border: pw.TableBorder(
                  bottom: pw.BorderSide(color: PdfColor.fromHex('#fff'))),
              columnWidths: {
                0: const pw.IntrinsicColumnWidth(),
              },
              children: [
                // Linha de cabeçalho da tabela
                pw.TableRow(
                  children: [
                    pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          'IDENTIFICAÇÃO E LOCALIZAÇÃO',
                          style: titleTextStyle,
                        ),
                      ),
                    ),
                    pw.Container(
                        color: PdfColor.fromHex('#649c7f'),
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(''),
                        ))
                  ],
                ),
                // Linhas de dados da tabela
                pw.TableRow(
                  children: [
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'ENTREVISTADO: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$name_entrevistado',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'CPF: ', style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$cpf_entrevistado',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(children: [
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'PROPRIETÁRIO: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$name_proprietario',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'CPF: ', style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$cpf_proprietario',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'CONTATO: ', style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$contato',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'ENDEREÇO: ', style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$endereco',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'CIDADE: ', style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$cidade',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'BAIRRO: ', style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$bairro',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'IMÓVEL ALUGADO: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$situacao',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'TEMPO DE OCUPAÇÃO: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$ocupacao',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'QUANTIDADE DE MORADORES: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$moradores',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'TEMPO DE CONSTRUÇÃO: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$construcao',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          "INFORMAÇÕES GERAIS DO IMÓVEL",
                          style: titleTextStyle,
                        ),
                      )),
                  pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text("")))
                ]),
                pw.TableRow(children: [
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'TIPO DE IMÓVEL (OU USO): ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$tipoImovel',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'QTD. DE QUARTOS: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$qtdQuarto',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'MURO: ', style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$muro',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'QTD. DE SUITES: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$qtdSuite',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'PAVIMENTOS: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$pavimento',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'QTD. DE BANHEIROS: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$qtdBanheiro',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'PADRÃO CONSTRUTIVO: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$padraoConstrutivo',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'GARAGEM: ', style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$garagem',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'IDADE APARENTE: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$idadeAparente',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'SITUAÇÃO DA ÁREA: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$situacaoArea',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3.3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'STIUAÇÃO: ', style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$aberto',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(9),
                      child: pw.RichText(
                        text: const pw.TextSpan(),
                      ),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Container(
                      color: PdfColor.fromHex('649c7f'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          "CONDIÇÕES ESTRUTURAIS DA EDIFICAÇÃO",
                          style: titleTextStyle,
                        ),
                      )),
                  pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text("")))
                ]),
                pw.TableRow(children: [
                  pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 2),
                        child: pw.Text("PISO", style: titleTextStyle),
                      )),
                  pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(6),
                          child: pw.Text("")))
                ]),
                pw.TableRow(children: [
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'TIPOLOGIA: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$tipologiaPiso',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'PATOLOGIA: ',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$patologiaPiso',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.RichText(
                        text: pw.TextSpan(
                          style: smallTextStyle,
                          children: [
                            pw.TextSpan(
                                text: 'TIPO DE PATOLOGIA: \n',
                                style: titleTextStyleTable),
                            pw.TextSpan(
                              text: '$tipoPatologiaPiso',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Container(
                    color: PdfColor.fromHex('#e4e4e4'),
                    child: pw.Padding(
                        padding: const pw.EdgeInsets.all(19.7),
                        child: pw.Text("")),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text("SUPERESTRUTURA", style: titleTextStyle),
                      )),
                  pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(7.8),
                          child: pw.Text("")))
                ]),
                pw.TableRow(
                  children: [
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'POSSÍVEL DE IDENTIFICAR: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$posivelIdentificar',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'ESTADO DE CONSERVAÇÃO: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$conservacao',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'PATOLOGIA: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$patologiaSuperestrutura',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'TIPO DE ELEMENTO: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$elemento',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      width: 100,
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'PATOLOGIA: \n',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$tipoPatologiaSuperestrutura',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(13.8),
                          child: pw.Text("")),
                    ),
                  ],
                ),
                pw.TableRow(children: [
                  pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text("ALVENARIA DE VEDAÇÃO",
                            style: titleTextStyle),
                      )),
                  pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(7.8),
                          child: pw.Text("")))
                ]),
                pw.TableRow(
                  children: [
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(5.3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'TIPOLOGIA: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$itensTipologiaEdi',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(5.3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'REVESTIMENTO: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$revestimento',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 12, left: 5),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'TIPO DE REVESTIMENTO: \n',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$itensRevestimento',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 34),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: '  PATOLOGIA: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$patologiaEdi',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 23, left: 5),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'TIPO DE PATOLOGIA: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$tipoPatologiaEdi',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 11, left: 5),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'CÔMODO: ', style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$comodo',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(children: [
                  pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text("FORRO", style: titleTextStyle),
                      )),
                  pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text("")))
                ]),
                pw.TableRow(
                  children: [
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(5.3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'TIPOLOGIA: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$tipologiaForro',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(5.3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'PATOLOGIA: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$patologiaForro',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(5.3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'PÉ SOLTO: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$peSolto',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(5.3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'TIPO DE PATOLOGIA: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$tipoPatologiaForro',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(children: [
                  pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text("COBERTURA", style: titleTextStyle),
                      )),
                  pw.Container(
                      color: PdfColor.fromHex('#649c7f'),
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text("")))
                ]),
                pw.TableRow(
                  children: [
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(5.3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'Laje: ', style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$laje',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(5.3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'TETO: ', style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$teto',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(5.3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'SIST. DE CAPTAÇÃO DE ÁGUAS PLUVIAIS: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$coleta',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(5.3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'TIPOLOGIA: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$tipologiaTelha',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(5.3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'PATOLOGIA: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$patologiaTelha',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      color: PdfColor.fromHex('#e4e4e4'),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(5.3),
                        child: pw.RichText(
                          text: pw.TextSpan(
                            style: smallTextStyle,
                            children: [
                              pw.TextSpan(
                                  text: 'TIPO DE PATOLOGIA: ',
                                  style: titleTextStyleTable),
                              pw.TextSpan(
                                text: '$tipoPatologiaTelha',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]));

  doc.addPage(pw.MultiPage(
      pageTheme: pageTheme,
      header: (final context) =>
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              color: PdfColor.fromHex('#649c7f'),
              height: 30,
              width: 400,
              child: pw.Text("LAUDO CAUTELAR DE VISTORIA DE VIZINHANÇA",
                  style: pw.TextStyle(
                      fontSize: 15,
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold)),
              margin: const pw.EdgeInsets.fromLTRB(0, -15, 0, 0),
              padding: const pw.EdgeInsets.only(left: 10),
            ),
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              color: PdfColor.fromHex('#649c7f'),
              height: 25,
              width: 115,
              child: pw.Text("CÓD.: $cod",
                  style: pw.TextStyle(
                      fontSize: 15,
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold)),
              margin: const pw.EdgeInsets.fromLTRB(5, -15, 0, 0),
              padding: const pw.EdgeInsets.only(left: 10),
            ),
          ]),
      footer: (context) => pw.Padding(
            padding: pw.EdgeInsets.only(bottom: -28, left: -33),
            child: pw.Container(
              child: pw.Image(
                alignment: pw.Alignment.topLeft,
                footerImage,
                fit: pw.BoxFit.contain,
                width: 600,
                height: 25,
              ),
            ),
          ),
      build: (final context) => [
            pw.Column(children: [
              pw.SizedBox(height: 20),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Container(
                    margin: pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                        "RESUMO DO LAUDO / VISÃO GERAL DA EDIFICAÇÃO",
                        textAlign: pw.TextAlign.center,
                        style: titleTextStyle),
                    color: PdfColor.fromHex('#649c7f'),
                    height: 20,
                    width: 500,
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(10),
                    margin: pw.EdgeInsets.only(left: 20),
                    color: PdfColor.fromHex('#e4e4e4'),
                    height: 700,
                    width: 500,
                    child: pw.Container(
                        child: pw.Column(children: [
                      pw.Column(children: [
                        pw.Text(resumo),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 30),
                        pw.Text(nomeCompleto),
                        pw.Text(cargo),
                        pw.Text(rg),
                        pw.Text(cpf),
                        pw.Text("E-mail: licitacao@certare.com.br"),
                        pw.Text("CONSÓRCIO CERTARE-ASSIST.",
                            style: pw.TextStyle(fontBold: pw.Font.timesBold())),
                      ])
                    ])),
                  ),
                ],
              ),
            ])
          ]));

// Capturar as duas fotos
  await capturePhotos(55);

// Adicionar as fotos ao PDF
  for (final photoPath in photoPaths) {
    addPhotoToPdf(doc, photoPath);
  }

  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  return const pw.PageTheme(
    margin: pw.EdgeInsets.symmetric(
        horizontal: 1 * PdfPageFormat.cm, vertical: 1 * PdfPageFormat.cm),
    textDirection: pw.TextDirection.ltr,
    orientation: pw.PageOrientation.portrait,
  );
}

Future<void> saveAsFile(
  final BuildContext context,
  final LayoutCallback build,
  final PdfPageFormat pageFormat,
) async {
  final bytes = await build(pageFormat);

  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/LCV.pdf');
  print('Save as file ${file.path}');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

void showPrintedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document printed succesfully!')));
}

void showSharedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document shared succesfully!')));
}
