import 'package:certare_app/util/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'forms/form_pdf.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({Key? key}) : super(key: key);

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  PrintingInfo? printingInfo;
  String cod = '';
  //form 1
  String nameEntrevistado = '';
  String cpfEntrevistado = '';
  String nameProprietario = '';
  String cpfProprietario = '';
  String contato = '';
  String endereco = '';
  String cidade = '';
  String bairro = '';
  String moradores = '';
  String situacao = '';
  String construcao = '';
  String ocupacao = '';
  //form 2
  String tipoImovel = '';
  String pavimento = '';
  String muro = '';
  String padraoConstrutivo = '';
  String idadeAparente = '';
  String aberto = '';
  String qtdQuarto = '';
  String qtdBanheiro = '';
  String qtdSuite = '';
  String garagem = '';
  String situacaoArea = '';
  //form 3
  String tipologiaPiso = '';
  String patologiaPiso = '';
  String tipoPatologiaPiso = '';
  //form 4
  String posivelIdentificar = '';
  String conservacao = '';
  String patologiaSuperestrutura = '';
  String elemento = '';
  String tipoPatologiaSuperestrutura = '';
  //form 5
  String itensTipologiaEdi = '';
  String revestimento = '';
  String itensRevestimento = '';
  String patologiaEdi = '';
  String tipoPatologiaEdi = '';
  String comodo = '';
  //form 6
  String tipologiaForro = '';
  String peSolto = '';
  String patologiaForro = '';
  String tipoPatologiaForro = '';
  //form 7
  String laje = '';
  String teto = '';
  String coleta = '';
  String tipologiaTelha = '';
  String patologiaTelha = '';
  String tipoPatologiaTelha = '';

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }

  void _handleFormSubmitted(FormData formData) {
    setState(() {
      cod = formData.cod;
      //form 1
      nameEntrevistado = formData.nomeEntrevistado;
      cpfEntrevistado = formData.cpfEntrevistado;
      nameProprietario = formData.nomeProprietario;
      cpfProprietario = formData.cpfProprietario;
      contato = formData.contato;
      endereco = formData.endereco;
      cidade = formData.cidade;
      bairro = formData.bairro;
      moradores = formData.moradores;
      situacao = formData.situacao;
      construcao = formData.construcao;
      ocupacao = formData.ocupacao;
      //form 2
      tipoImovel = formData.tipoImovel;
      pavimento = formData.pavimento;
      muro = formData.muro;
      padraoConstrutivo = formData.padraoConstrutivo;
      idadeAparente = formData.idadeAparente;
      aberto = formData.aberto;
      qtdQuarto = formData.qtdQuarto;
      qtdBanheiro = formData.qtdBanheiro;
      qtdSuite = formData.qtdSuite;
      garagem = formData.garagem;
      situacaoArea = formData.situacaoArea;
      //form 3
      tipologiaPiso = formData.tipologiaPiso;
      patologiaPiso = formData.patologiaPiso;
      tipoPatologiaPiso = formData.tipoPatologiaPiso;
      //form 4
      posivelIdentificar = formData.posivelIdentificar;
      conservacao = formData.conservacao;
      patologiaSuperestrutura = formData.patologiaSuperestrutura;
      elemento = formData.elemento;
      tipoPatologiaSuperestrutura = formData.tipoPatologiaSuperestrutura;
      //form 5
      itensTipologiaEdi = formData.itensTipologiaEdi;
      revestimento = formData.revestimento;
      itensRevestimento = formData.itensRevestimento;
      patologiaEdi = formData.patologiaEdi;
      tipoPatologiaEdi = formData.tipoPatologiaEdi;
      comodo = formData.comodo;
      //form 6
      tipologiaForro = formData.tipologiaForro;
      peSolto = formData.peSolto;
      patologiaForro = formData.patologiaForro;
      tipoPatologiaForro = formData.tipoPatologiaForro;
      //form 7
      laje = formData.laje; 
      teto = formData.teto; 
      coleta = formData.coleta;
      tipologiaTelha = formData.tipologiaTelha; 
      patologiaTelha = formData.patologiaTelha;
      tipoPatologiaTelha = formData.tipoPatologiaTelha;
    });
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        const PdfPreviewAction(
          icon: Icon(Icons.save),
          onPressed: saveAsFile,
        ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laudo - Certare',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: cod.isEmpty
          ? FormPage(onFormSubmitted: _handleFormSubmitted)
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: PdfPreview(
                      maxPageWidth: 700,
                      actions: actions,
                      onShared: (_) => showSharedToast(context),
                      build: (format) => generatePdf(
                        format,
                        cod,
                        //form 1
                        nameEntrevistado,
                        cpfEntrevistado,
                        nameProprietario,
                        cpfProprietario,
                        contato,
                        endereco,
                        cidade,
                        bairro,
                        moradores,
                        situacao,
                        construcao,
                        ocupacao,
                        //form 2
                        tipoImovel,
                        pavimento,
                        muro,
                        padraoConstrutivo,
                        idadeAparente,
                        aberto,
                        qtdQuarto,
                        qtdBanheiro,
                        qtdSuite,
                        garagem,
                        situacaoArea,
                        //form 3
                        tipologiaPiso,
                        patologiaPiso,
                        tipoPatologiaPiso,
                        //form 4
                        posivelIdentificar,
                        conservacao,
                        patologiaSuperestrutura,
                        elemento,
                        tipoPatologiaSuperestrutura,
                        //form 5
                        itensTipologiaEdi,
                        revestimento,
                        itensRevestimento,
                        patologiaEdi,
                        tipoPatologiaEdi,
                        comodo,
                        //form 6
                        tipologiaForro,
                        peSolto,
                        patologiaForro,
                        tipoPatologiaForro,
                        //form 7
                        laje,
                        teto,
                        coleta,
                        tipologiaTelha,
                        patologiaTelha,
                        tipoPatologiaTelha,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
