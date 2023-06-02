import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;


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
) async {
  final doc = pw.Document(
    title: 'Flutter School',
  );
  final logoImage = pw.MemoryImage(
    (await rootBundle.load('assets/images/certare.png')).buffer.asUint8List(),
  );
  final font = await rootBundle.load('assets/fonts/Prototype.ttf');
  final ttf = pw.Font.ttf(font);

  final pageTheme = await _myPageTheme(format);

  const smallTextStyle = pw.TextStyle(
    fontSize: 10,
  );
  const titleTextStyle = pw.TextStyle(fontSize: 10, color: PdfColors.white);

  // Função para capturar uma foto e retornar o caminho do arquivo
  Future<String?> capturePhoto() async {
    final imagePicker = ImagePicker();
    final imageFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (imageFile == null) return null;
    return imageFile.path;
  }

  // Função para adicionar uma foto ao documento PDF
  Future<void> addPhotoToPdf(String? imagePath) async {
    if (imagePath == null) return;
    final image = pw.MemoryImage(File(imagePath).readAsBytesSync());
    doc.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Image(image);
        },
      ),
    );
  }

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
              height: 30,
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
      // footer: (final context) => pw.Row(children: [
      //       pw.Container(
      //         alignment: pw.Alignment.center,
      //         color: PdfColor.fromHex('#649c7f'),
      //         height: 25,
      //         width: 700,
      //         child: pw.Text("www.certare.com",
      //             style: pw.TextStyle(
      //                 fontSize: 10,
      //                 color: PdfColors.white,
      //                 fontWeight: pw.FontWeight.bold)),
      //         margin: const pw.EdgeInsets.fromLTRB(-100, 0, 0, -30),
      //       )
      //     ]),
      build: (final context) => [
            pw.Container(
                padding: const pw.EdgeInsets.only(left: -5, bottom: 0),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Table(
                                    tableWidth: pw.TableWidth.max,
                                    border: pw.TableBorder(
                                        bottom: pw.BorderSide(
                                            color: PdfColor.fromHex('#fff'))),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5),
                                              child: pw.Text(
                                                'IDENTIFICAÇÃO E LOCALIZAÇÃO',
                                                style: titleTextStyle,
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                              color:
                                                  PdfColor.fromHex('#649c7f'),
                                              child: pw.Padding(
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        10.7),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'ENTREVISTADO: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
                                                    pw.TextSpan(
                                                      text:
                                                          '$name_entrevistado',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            color: PdfColor.fromHex('#e4e4e4'),
                                            child: pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.all(5),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'CPF: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'PROPRIETÁRIO: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'CPF: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'CONTATO: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'ENDEREÇO: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'CIDADE: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'BAIRRO: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'IMÓVEL ALUGADO: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'TEMPO DE OCUPAÇÃO: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text:
                                                        'QUANTIDADE DE MORADORES: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text:
                                                        'TEMPO DE CONSTRUÇÃO: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.5),
                                              child: pw.Text(
                                                "INFORMAÇÕES GERAIS DO IMÓVEL",
                                                style: titleTextStyle,
                                              ),
                                            )),
                                        pw.Container(
                                            color: PdfColor.fromHex('#649c7f'),
                                            child: pw.Padding(
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        11.5),
                                                child: pw.Text("")))
                                      ]),
                                      pw.TableRow(children: [
                                        pw.Container(
                                          color: PdfColor.fromHex('#e4e4e4'),
                                          child: pw.Padding(
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text:
                                                        'TIPO DE IMÓVEL (OU USO): ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'QTD. DE QUARTOS: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'MURO: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'QTD. DE SUITES: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'PAVIMENTOS: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'QTD. DE BANHEIROS: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text:
                                                        'PADRÃO CONSTRUTIVO: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'GARAGEM: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'IDADE APARENTE: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding: const pw.EdgeInsets.all(5),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'SITUAÇÃO DA ÁREA: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding:
                                                const pw.EdgeInsets.all(5.3),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'STIUAÇÃO: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding:
                                                const pw.EdgeInsets.all(11.4),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5),
                                              child: pw.Text(
                                                "CONDIÇÕES ESTRUTURAIS DA EDIFICAÇÃO",
                                                style: titleTextStyle,
                                              ),
                                            )),
                                        pw.Container(
                                            color: PdfColor.fromHex('#649c7f'),
                                            child: pw.Padding(
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        10.9),
                                                child: pw.Text("")))
                                      ]),
                                      pw.TableRow(children: [
                                        pw.Container(
                                            color: PdfColor.fromHex('#649c7f'),
                                            child: pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.all(5),
                                              child: pw.Text("PISO",
                                                  style: titleTextStyle),
                                            )),
                                        pw.Container(
                                            color: PdfColor.fromHex('#649c7f'),
                                            child: pw.Padding(
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        10.5),
                                                child: pw.Text("")))
                                      ]),
                                      pw.TableRow(children: [
                                        pw.Container(
                                          color: PdfColor.fromHex('#e4e4e4'),
                                          child: pw.Padding(
                                            padding:
                                                const pw.EdgeInsets.all(5.3),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'TIPOLOGIA: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding:
                                                const pw.EdgeInsets.all(5.3),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text: 'PATOLOGIA: ',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                            padding:
                                                const pw.EdgeInsets.all(5.3),
                                            child: pw.RichText(
                                              text: pw.TextSpan(
                                                style: smallTextStyle,
                                                children: [
                                                  pw.TextSpan(
                                                    text:
                                                        'TIPO DE PATOLOGIA: \n',
                                                    style: pw.TextStyle(
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(17),
                                              child: pw.Text("")),
                                        ),
                                      ]),
                                      pw.TableRow(children: [
                                        pw.Container(
                                            color: PdfColor.fromHex('#649c7f'),
                                            child: pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.all(5),
                                              child: pw.Text("SUPERESTRUTURA",
                                                  style: titleTextStyle),
                                            )),
                                        pw.Container(
                                            color: PdfColor.fromHex('#649c7f'),
                                            child: pw.Padding(
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        10.5),
                                                child: pw.Text("")))
                                      ]),
                                      pw.TableRow(
                                        children: [
                                          pw.Container(
                                            color: PdfColor.fromHex('#e4e4e4'),
                                            child: pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text:
                                                          'POSSÍVEL DE IDENTIFICAR: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
                                                    pw.TextSpan(
                                                      text:
                                                          '$posivelIdentificar',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            color: PdfColor.fromHex('#e4e4e4'),
                                            child: pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text:
                                                          'ESTADO DE CONSERVAÇÃO: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'PATOLOGIA: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
                                                    pw.TextSpan(
                                                      text:
                                                          '$patologiaSuperestrutura',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            color: PdfColor.fromHex('#e4e4e4'),
                                            child: pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text:
                                                          'TIPO DE ELEMENTO: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'PATOLOGIA: \n',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
                                                    pw.TextSpan(
                                                      text:
                                                          '$tipoPatologiaSuperestrutura',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            color: PdfColor.fromHex('#e4e4e4'),
                                            child: pw.Padding(
                                                padding:
                                                    const pw.EdgeInsets.all(17),
                                                child: pw.Text("")),
                                          ),
                                        ],
                                      ),
                                      pw.TableRow(children: [
                                        pw.Container(
                                            color: PdfColor.fromHex('#649c7f'),
                                            child: pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.all(5),
                                              child: pw.Text(
                                                  "ALVENARIA DE VEDAÇÃO",
                                                  style: titleTextStyle),
                                            )),
                                        pw.Container(
                                            color: PdfColor.fromHex('#649c7f'),
                                            child: pw.Padding(
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        10.5),
                                                child: pw.Text("")))
                                      ]),
                                      pw.TableRow(
                                        children: [
                                          pw.Container(
                                            color: PdfColor.fromHex('#e4e4e4'),
                                            child: pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'TIPOLOGIA: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
                                                    pw.TextSpan(
                                                      text:
                                                          '$itensTipologiaEdi',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            color: PdfColor.fromHex('#e4e4e4'),
                                            child: pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'REVESTIMENTO: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text:
                                                          'TIPO DE REVESTIMENTO: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
                                                    pw.TextSpan(
                                                      text:
                                                          '$itensRevestimento',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            color: PdfColor.fromHex('#e4e4e4'),
                                            child: pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'PATOLOGIA: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text:
                                                          'TIPO DE PATOLOGIA: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'CÔMODO: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5),
                                              child: pw.Text("FORRO",
                                                  style: titleTextStyle),
                                            )),
                                        pw.Container(
                                            color: PdfColor.fromHex('#649c7f'),
                                            child: pw.Padding(
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        10.5),
                                                child: pw.Text("")))
                                      ]),
                                      pw.TableRow(
                                        children: [
                                          pw.Container(
                                            color: PdfColor.fromHex('#e4e4e4'),
                                            child: pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'TIPOLOGIA: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'PATOLOGIA: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'PÉ SOLTO: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text:
                                                          'TIPO DE PATOLOGIA: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
                                                    pw.TextSpan(
                                                      text:
                                                          '$tipoPatologiaForro',
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
                                              padding:
                                                  const pw.EdgeInsets.all(5),
                                              child: pw.Text("COBERTURA",
                                                  style: titleTextStyle),
                                            )),
                                        pw.Container(
                                            color: PdfColor.fromHex('#649c7f'),
                                            child: pw.Padding(
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        10.5),
                                                child: pw.Text("")))
                                      ]),
                                      pw.TableRow(
                                        children: [
                                          pw.Container(
                                            color: PdfColor.fromHex('#e4e4e4'),
                                            child: pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'Laje: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'TETO: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text:
                                                          'SIST. DE CAPTAÇÃO DE ÁGUAS PLUVIAIS: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'TIPOLOGIA: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text: 'PATOLOGIA: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
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
                                              padding:
                                                  const pw.EdgeInsets.all(5.3),
                                              child: pw.RichText(
                                                text: pw.TextSpan(
                                                  style: smallTextStyle,
                                                  children: [
                                                    pw.TextSpan(
                                                      text:
                                                          'TIPO DE PATOLOGIA: ',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                    ),
                                                    pw.TextSpan(
                                                      text:
                                                          '$tipoPatologiaTelha',
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
                                ])
                          ])
                    ]))
          ]));
  
  // Capturar as fotos e adicioná-las ao PDF
  final List<String?> photoPaths = [];
  for (int i = 0; i < 1; i++) {
    final photoPath = await capturePhoto();
    photoPaths.add(photoPath);
  }

  for (final photoPath in photoPaths) {
    await addPhotoToPdf(photoPath!);
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
  final file = File('$appDocPath/document.pdf');
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
