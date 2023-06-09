import 'package:certare_app/pages/home.dart';
import 'package:certare_app/widgets/drop_down_field.dart';
import 'package:certare_app/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../widgets/multi_select_field.dart';

class FormData {
  final String cod;
  //form 1
  final String nomeEntrevistado;
  final String cpfEntrevistado;
  final String nomeProprietario;
  final String cpfProprietario;
  final String contato;
  final String endereco;
  final String cidade;
  final String bairro;
  final String moradores;
  final String situacao;
  final String construcao;
  final String ocupacao;
  //form 2
  final String tipoImovel;
  final String pavimento;
  final String muro;
  final String padraoConstrutivo;
  final String idadeAparente;
  final String aberto;
  final String qtdQuarto;
  final String qtdBanheiro;
  final String qtdSuite;
  final String garagem;
  final String situacaoArea;
  //form 3
  final String tipologiaPiso;
  final String patologiaPiso;
  final String tipoPatologiaPiso;
  //form 4
  final String posivelIdentificar;
  final String conservacao;
  final String patologiaSuperestrutura;
  final String elemento;
  final String tipoPatologiaSuperestrutura;
  //form 5
  final String itensTipologiaEdi;
  final String revestimento;
  final String itensRevestimento;
  final String patologiaEdi;
  final String tipoPatologiaEdi;
  final String comodo;
  //form 6
  final String tipologiaForro;
  final String peSolto;
  final String patologiaForro;
  final String tipoPatologiaForro;
  //form 7
  final String laje;
  final String teto;
  final String coleta;
  final String tipologiaTelha;
  final String patologiaTelha;
  final String tipoPatologiaTelha;
  //form 8
  final String resumo;
  final String nomeCompleto;
  final String cargo;
  final String rg;
  final String cpf;

  FormData({
    required this.cod,
    //form1
    required this.nomeEntrevistado,
    required this.cpfEntrevistado,
    required this.nomeProprietario,
    required this.cpfProprietario,
    required this.contato,
    required this.endereco,
    required this.cidade,
    required this.bairro,
    required this.moradores,
    required this.situacao,
    required this.construcao,
    required this.ocupacao,
    //form2
    required this.tipoImovel,
    required this.pavimento,
    required this.muro,
    required this.padraoConstrutivo,
    required this.idadeAparente,
    required this.aberto,
    required this.qtdQuarto,
    required this.qtdBanheiro,
    required this.qtdSuite,
    required this.garagem,
    required this.situacaoArea,
    //form3
    required this.tipologiaPiso,
    required this.patologiaPiso,
    required this.tipoPatologiaPiso,
    //form4
    required this.posivelIdentificar,
    required this.conservacao,
    required this.patologiaSuperestrutura,
    required this.elemento,
    required this.tipoPatologiaSuperestrutura,
    //form 5
    required this.itensTipologiaEdi,
    required this.revestimento,
    required this.itensRevestimento,
    required this.patologiaEdi,
    required this.tipoPatologiaEdi,
    required this.comodo,
    //form 6
    required this.tipologiaForro,
    required this.peSolto,
    required this.patologiaForro,
    required this.tipoPatologiaForro,
    //form 7
    required this.laje,
    required this.teto,
    required this.coleta,
    required this.tipologiaTelha,
    required this.patologiaTelha,
    required this.tipoPatologiaTelha,
    //form 8
    required this.resumo,
    required this.nomeCompleto,
    required this.cargo,
    required this.rg,
    required this.cpf,
  });
}

class FormPage extends StatefulWidget {
  const FormPage({Key? key, required this.onFormSubmitted}) : super(key: key);

  final void Function(FormData) onFormSubmitted;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  late List<Step> _formSteps;
  List<IconData> stepIcons = [
    Icons.check_circle, // Ícone para passo concluído
    Icons.edit, // Ícone para passo em andamento
  ];

  // Formulario 1
  FormData _formData = FormData(
    cod: '',
    // Formulario 1
    nomeEntrevistado: '',
    cpfEntrevistado: '',
    nomeProprietario: '',
    cpfProprietario: '',
    contato: '',
    endereco: '',
    cidade: '',
    bairro: '',
    moradores: '',
    situacao: '',
    construcao: '',
    ocupacao: '',
    // Formulario 2
    tipoImovel: '',
    pavimento: '',
    muro: '',
    padraoConstrutivo: '',
    idadeAparente: '',
    aberto: '',
    qtdQuarto: '',
    qtdBanheiro: '',
    qtdSuite: '',
    garagem: '',
    situacaoArea: '',
    // Formulario 3
    tipologiaPiso: '',
    patologiaPiso: '',
    tipoPatologiaPiso: '',
    // Formulario 4
    posivelIdentificar: '',
    patologiaSuperestrutura: '',
    conservacao: '',
    elemento: '',
    tipoPatologiaSuperestrutura: '',
    // Fprmulario 5
    itensTipologiaEdi: '',
    revestimento: '',
    itensRevestimento: '',
    patologiaEdi: '',
    tipoPatologiaEdi: '',
    comodo: '',
    // Formulario 6
    tipologiaForro: '',
    peSolto: '',
    patologiaForro: '',
    tipoPatologiaForro: '',
    // Formulario 7
    laje: '',
    teto: '',
    coleta: '',
    tipologiaTelha: '',
    patologiaTelha: '',
    tipoPatologiaTelha: '',
    // Formulario 8
    resumo: '',
    nomeCompleto: '',
    cargo: '',
    rg: '',
    cpf: '',
  );

  final _codController = TextEditingController();
  // Formulario 1
  final List<String> _alugado = ['Sim', 'Não'];
  String? _selectedRented;
  final _nameController = TextEditingController();
  final _cpfEntrevistadoController = TextEditingController();
  final _proprietarioController = TextEditingController();
  final _proprietarioCpfController = TextEditingController();
  final _contatoController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _bairroController = TextEditingController();
  final _moradoresController = TextEditingController();
  final _construcaoController = TextEditingController();
  final _ocupacaoController = TextEditingController();

  // Formulario 2
  final List<String> _typeProperty = [
    'Casa',
    'Apartamento',
    'Comercial',
    'Sitio',
    'Abandonado'
  ];
  final _pavementController = TextEditingController();
  final List<String> _wall = ['Sim', 'Não'];
  final List<String> _constructivePattern = ['Baixo', 'Médio', 'Alto'];
  final List<String> _apparentAge = [
    'Novo (<10 anos)',
    'Moderado (Entre 10 e 30 anos)',
    'Antigo (entre 30 e 50 anos)',
    'Histórico (>50 anos)'
  ];
  final List<String> _situation = ['Aberto', 'Fechado', 'Recusa'];
  final _numberRooms = TextEditingController();
  final _numberBathrooms = TextEditingController();
  final _numberSuites = TextEditingController();
  final List<String> _garage = ['Sim', 'Não'];
  final List<String> _situationArea = [
    'Normal',
    'Alagadiça',
    'Leito de rua',
    'Área de risco'
  ];
  String? _selectedType;
  String? _selectedWall;
  String? _selectedConstructive;
  String? _selectedSituation;
  String? _selectedGarage;
  String? _selectedAge;
  String? _selectedArea;

  // Formulario 3
  final List<String> _typologyFloor = [
    'Chão Batido',
    'Concreto Aparente',
    'Piso Cerâmico',
    'Piso Porcelanato',
    'Outros'
  ];
  List<String> _selectedTypology = [];
  final List<String> _patologyFloor = ['Sim', 'Não', 'Não se aplica'];
  String? _selectedPatologyFloor;
  final List<String> _patologyTypeFloor = [
    'Infiltrações',
    'Fissuras',
    'Armaduras expostas',
    'Vícios construtivos',
    'Eflorescência',
    'Bicheiras',
    'Disgregação',
    'Desplacamento/Esfoliação',
    'Não se aplica',
  ];
  List<String> _selectedTypePatologyFloor = [];

  // Formulario 4
  final List<String> _possibleIdentify = ['Sim', 'Não'];
  final List<String> _conservation = [
    'Bom',
    'Ruim',
    'Péssimo',
    'Risco eminente de colapso'
  ];
  final List<String> _patologySuperstructure = ['Sim', 'Não'];
  final List<String> _typeElementList = [
    'Pilarete',
    'Pilar',
    'Viga',
    'Vigota',
    'Laje',
    'Não se aplica',
  ];
  final List<String> _patologySuperstructureTypes = [
    'Infiltrações',
    'Fissuras',
    'Armaduras expostas',
    'Vícios construtivos',
    'Eflorescência',
    'Bicheiras',
    'Disgregação/Desplacamento/Esfoliação',
    'Não se aplica',
  ];
  String? _selectedIdentify;
  String? _selectedConservation;
  String? _selectedPatologySuperstructure;
  List<String> _selectedTypePatologySuperstructure = [];
  List<String> _selectedElements = [];

  // Formulario 5
  final List<String> _typologyItemsEdi = [
    'Adobe',
    'Taipa',
    'Tijolo Ceramico',
    'Bloco de concreto',
    'Gesso',
    'Drywall'
  ];
  final List<String> _coatingItems = ['Sim', 'Não'];
  final List<String> _coatingTypeItems = [
    'Chapisco',
    'Reboco',
    'Revestimento ceramico',
    'Massa corrida',
    'Massa Acrilica',
    'Tinta PVA',
    'Tinta acrílica',
    'Tinta EPOX',
    'Não se aplica',
  ];
  final List<String> _patolgyItems = ['Sim', 'Não'];
  final List<String> _typePatologyItems = [
    'Infiltração',
    'Recalques',
    'Fissuras',
    'Deslocamento',
    'Empolamento',
    'Deslocamento em placas',
    'Não se aplica',
  ];
  final List<String> _convenientItems = [
    'Fachada',
    'Garagem',
    'Sala',
    'Cozinha',
    'Banheiro',
    'Quarto',
    'Área externa',
    'Não se aplica',
  ];
  String? _selectTipologyItemsEdi;
  String? _selectCoatingTypeItems;
  String? _selectPatolgyItems;
  List<String> _selectedTypeCoatingEdi = [];
  List<String> _selectedTypePatologyEdi = [];
  List<String> _selectedConvenientEdi = [];

  // Formulario 6
  final List<String> _typologyItemsLining = [
    'PVC',
    'Gesso',
    'Madeira',
    'Drywall'
  ];
  final List<String> _footItems = ['Sim', 'Não'];
  final List<String> _patologyItemsLining = ['Sim', 'Não'];
  final List<String> _typePatologyItemsLining = [
    'Mancha',
    'Físsura',
    'Rachaduras',
    'Não se aplica',
  ];
  String? _selectTipologyItemsLining;
  String? _selectFootItems;
  String? _selectPatolgyItemsLining;
  List<String> _selectedTypePatologyLining = [];

  // Formulario 7
  final List<String> _slabItems = ['Sim', 'Não'];
  final List<String> _roofStructureItems = [
    'Madeira',
    'Metálica',
    'Não se aplica'
  ];
  final List<String> _collectionSystemItems = ['Sim', 'Não'];
  final List<String> _typologyTilesItem = [
    'Cerâmica',
    'Fibrocimento',
    'Galvanizada'
  ];
  final List<String> _patologyItems = ['Sim', 'Não'];
  final List<String> _patologyTypeItems = [
    'Falta de comeeira',
    'Abaulamentos',
    'Madeira deteriorada',
    'Falta de apaios',
    'Não se aplica',
  ];
  String? _selectedSlab;
  String? _selectedRoof;
  String? _selectedCollenction;
  String? _selectedTypologyTiles;
  String? _selectedPatologyTiles;
  List<String> _selectedPatologyRoof = [];

  // Formulario 8
  final _resumo = TextEditingController();
  final _nomeCompleto = TextEditingController();
  final _cargo = TextEditingController();
  final _rg = TextEditingController();
  final _cpf = TextEditingController();

  // Formaters
  final _cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _contatoFormatter = MaskTextInputFormatter(
    mask: '## #.####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _quantidadeFormatter = MaskTextInputFormatter(mask: '##');

  @override
  void initState() {
    super.initState();
    _formSteps = _buildFormSteps();
  }

  List<Step> _buildFormSteps() {
    return [
      Step(
        title: const Text(
          'IDENTIFICAÇÃO E LOCALIZAÇÃO',
          style: TextStyle(
            fontFamily: 'Prototype',
            fontSize: 18,
          ),
        ),
        content: Column(
          children: [
            InputField(
              inputController: _codController,
              textLabel: 'Código do laudo',
              suffixWidget: const Icon(Icons.info),
              isRequired: true,
            ),
            const SizedBox(height: 10),
            InputField(
              inputController: _nameController,
              textLabel: 'Nome do entrevistado',
              suffixWidget: const Icon(Icons.person),
              isRequired: true,
            ),
            const SizedBox(height: 10),
            InputField(
              inputController: _cpfEntrevistadoController,
              textLabel: 'CPF do entrevistado',
              suffixWidget: const Icon(Icons.assignment_ind),
              formatter: _cpfFormatter,
              isRequired: true,
            ),
            const SizedBox(height: 10),
            InputField(
              inputController: _proprietarioController,
              textLabel: 'Nome do proprietário',
              suffixWidget: const Icon(Icons.person_outline),
              isRequired: true,
            ),
            const SizedBox(height: 10),
            InputField(
              inputController: _proprietarioCpfController,
              textLabel: 'CPF do proprietário',
              suffixWidget: const Icon(Icons.assignment_ind_outlined),
              formatter: _cpfFormatter,
              isRequired: true,
            ),
            const SizedBox(height: 10),
            InputField(
              inputController: _contatoController,
              textLabel: 'Contato',
              suffixWidget: const Icon(Icons.location_on),
              isRequired: true,
              formatter: _contatoFormatter,
            ),
            const SizedBox(height: 10),
            InputField(
              inputController: _enderecoController,
              textLabel: 'Endereço',
              suffixWidget: const Icon(Icons.location_on),
              isRequired: true,
            ),
            const SizedBox(height: 10),
            InputField(
              inputController: _cidadeController,
              textLabel: 'Cidade',
              suffixWidget: const Icon(Icons.location_city),
              isRequired: true,
            ),
            const SizedBox(height: 10),
            InputField(
              inputController: _bairroController,
              textLabel: 'Bairro',
              suffixWidget: const Icon(Icons.location_city),
              isRequired: true,
            ),
            const SizedBox(height: 10),
            InputField(
              inputController: _moradoresController,
              textLabel: 'Quantidade de Moradores',
              suffixWidget: const Icon(Icons.format_list_numbered),
              formatter: _quantidadeFormatter,
              isRequired: true,
            ),
            const SizedBox(height: 10),
            DropDownField(
              labelText: 'Alugado',
              items: _alugado,
              value: _selectedRented,
              onChanged: (newValue) {
                setState(() {
                  _selectedRented = newValue;
                });
              },
            ),
            const SizedBox(height: 10),
            InputField(
              inputController: _construcaoController,
              textLabel: 'Tempo de Construção',
              suffixWidget: const Icon(Icons.construction),
              isRequired: true,
            ),
            const SizedBox(height: 10),
            InputField(
              inputController: _ocupacaoController,
              textLabel: 'Tempo de Ocupação',
              suffixWidget: const Icon(Icons.date_range_sharp),
              isRequired: true,
            ),
          ],
        ),
        isActive: _currentStep >= 0,
        state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(
          'INFORMAÇÕES GERAIS DO IMÓVEL ',
          style: TextStyle(
            fontFamily: 'Prototype',
            fontSize: 18,
          ),
        ),
        content: Column(
          children: [
            DropDownField(
              labelText: 'Tipo de imovel',
              items: _typeProperty,
              value: _selectedType,
              onChanged: (newValue) {
                setState(() {
                  _selectedType = newValue;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            InputField(
              inputController: _pavementController,
              textLabel: 'Pavimentos',
              suffixWidget: const Icon(Icons.add_road),
              formatter: _quantidadeFormatter,
              isRequired: true,
            ),
            const SizedBox(
              height: 10,
            ),
            DropDownField(
              labelText: 'Muro',
              items: _wall,
              value: _selectedWall,
              onChanged: (newValue) {
                setState(() {
                  _selectedWall = newValue;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropDownField(
              labelText: 'Padrão construtivo',
              items: _constructivePattern,
              value: _selectedConstructive,
              onChanged: (newValue) {
                setState(() {
                  _selectedConstructive = newValue;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropDownField(
              labelText: 'Idade aparente',
              items: _apparentAge,
              value: _selectedAge,
              onChanged: (value) {
                setState(() {
                  _selectedAge = value;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropDownField(
              labelText: 'Situação',
              items: _situation,
              value: _selectedSituation,
              onChanged: (newValue) {
                setState(() {
                  _selectedSituation = newValue;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            InputField(
              inputController: _numberRooms,
              textLabel: 'Quantidade de quartos',
              suffixWidget: const Icon(Icons.single_bed_outlined),
              formatter: _quantidadeFormatter,
              isRequired: true,
            ),
            const SizedBox(
              height: 10,
            ),
            InputField(
              inputController: _numberBathrooms,
              textLabel: 'Quantidade de banheiros',
              suffixWidget: const Icon(Icons.bathroom_outlined),
              formatter: _quantidadeFormatter,
              isRequired: true,
            ),
            const SizedBox(
              height: 10,
            ),
            InputField(
              inputController: _numberSuites,
              textLabel: 'Quantidade de suites',
              suffixWidget:
                  const Icon(Icons.airline_seat_individual_suite_outlined),
              formatter: _quantidadeFormatter,
              isRequired: true,
            ),
            const SizedBox(
              height: 10,
            ),
            DropDownField(
              labelText: 'Garagem',
              items: _garage,
              value: _selectedGarage,
              onChanged: (newValue) {
                setState(() {
                  _selectedGarage = newValue;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropDownField(
              labelText: 'Situação da área',
              items: _situationArea,
              value: _selectedArea,
              onChanged: (newValue) {
                setState(() {
                  _selectedArea = newValue;
                });
              },
            )
          ],
        ),
        isActive: _currentStep >= 1,
        state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(
          'CONDIÇÕES ESTRUTURAIS DA EDIFICAÇÃO',
          style: TextStyle(
            fontFamily: 'Prototype',
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          "PISO",
          style: TextStyle(fontFamily: 'Prototype', fontSize: 14),
        ),
        content: Column(
          children: [
            MultiSelectField(
              title: 'Tipologia',
              buttonText: 'Selecione as tipologias',
              cancelText: 'CANCELAR',
              items: _typologyFloor.map((e) => MultiSelectItem(e, e)).toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (selectedItems) {
                _selectedTypology
                    .clear(); // Limpa os valores selecionados anteriores, se houverem
                for (var item in selectedItems!) {
                  _selectedTypology.add(
                      item); // Adiciona o valor selecionado à lista de valores
                }
                // Você pode fazer qualquer coisa com os valores selecionados aqui
                for (var value in _selectedTypology) {
                  print('Item selecionado: $value');
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropDownField(
              labelText: 'Patologia',
              items: _patologyFloor,
              value: _selectedPatologyFloor,
              onChanged: (newValue) {
                setState(() {
                  _selectedPatologyFloor = newValue;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MultiSelectField(
              title: 'Patologia',
              buttonText: 'Selecione as patologias (Se necessário)',
              cancelText: 'CANCELAR',
              items:
                  _patologyTypeFloor.map((e) => MultiSelectItem(e, e)).toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (selectedItems) {
                _selectedTypePatologyFloor
                    .clear(); // Limpa os valores selecionados anteriores, se houverem
                for (var item in selectedItems!) {
                  _selectedTypePatologyFloor.add(
                      item); // Adiciona o valor selecionado à lista de valores
                }
                // Você pode fazer qualquer coisa com os valores selecionados aqui
                for (var value in _selectedTypePatologyFloor) {
                  print('Item selecionado: $value');
                }
              },
            ),
          ],
        ),
        isActive: _currentStep >= 2,
        state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(
          'CONDIÇÕES ESTRUTURAIS DA EDIFICAÇÃO',
          style: TextStyle(
            fontFamily: 'Prototype',
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          "SUPERESTRUTURA",
          style: TextStyle(fontFamily: 'Prototype', fontSize: 14),
        ),
        content: Column(
          children: [
            DropDownField(
              labelText: 'Possivel identificar?',
              items: _possibleIdentify,
              value: _selectedIdentify,
              onChanged: (newValue) {
                setState(() {
                  _selectedIdentify = newValue;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropDownField(
              labelText: 'Estado de conservação',
              items: _conservation,
              value: _selectedConservation,
              onChanged: (newValue) {
                setState(() {
                  _selectedConservation = newValue;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropDownField(
              labelText: 'Patologia',
              items: _patologySuperstructure,
              value: _selectedPatologySuperstructure,
              onChanged: (newValue) {
                setState(() {
                  _selectedPatologySuperstructure = newValue;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MultiSelectField(
              title: 'Tipo de elemento',
              buttonText: 'Selecione os elementos',
              cancelText: 'CANCELAR',
              items:
                  _typeElementList.map((e) => MultiSelectItem(e, e)).toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (selectedItems) {
                _selectedElements
                    .clear(); // Limpa os valores selecionados anteriores, se houverem
                for (var item in selectedItems!) {
                  _selectedElements.add(
                      item); // Adiciona o valor selecionado à lista de valores
                }
                // Você pode fazer qualquer coisa com os valores selecionados aqui
                for (var value in _selectedElements) {
                  print('Item selecionado: $value');
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MultiSelectField(
              title: 'Tipo de patologia',
              buttonText: 'Selecione as patologias',
              cancelText: 'CANCELAR',
              items: _patologySuperstructureTypes
                  .map((e) => MultiSelectItem(e, e))
                  .toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (selectedItems) {
                _selectedTypePatologySuperstructure
                    .clear(); // Limpa os valores selecionados anteriores, se houverem
                for (var item in selectedItems!) {
                  _selectedTypePatologySuperstructure.add(
                      item); // Adiciona o valor selecionado à lista de valores
                }
                // Você pode fazer qualquer coisa com os valores selecionados aqui
                for (var value in _selectedTypePatologySuperstructure) {
                  print('Item selecionado: $value');
                }
              },
            ),
          ],
        ),
        isActive: _currentStep >= 3,
        state: _currentStep >= 3 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(
          'CONDIÇÕES ESTRUTURAIS DA EDIFICAÇÃO',
          style: TextStyle(
            fontFamily: 'Prototype',
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          "ALVENARIA DE VEDAÇÃO",
          style: TextStyle(fontFamily: 'Prototype', fontSize: 14),
        ),
        content: Column(
          children: [
            DropDownField(
              labelText: 'Selecione uma tipologia',
              items: _typologyItemsEdi,
              value: _selectTipologyItemsEdi,
              onChanged: (newValue) {
                setState(() {
                  _selectTipologyItemsEdi = newValue;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropDownField(
              labelText: 'Possuí revestimento?',
              items: _coatingItems,
              value: _selectCoatingTypeItems,
              onChanged: (newValue) {
                setState(() {
                  _selectCoatingTypeItems = newValue;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MultiSelectField(
              title: 'Tipo de revestimento',
              buttonText: 'Selecione os revestimentos',
              cancelText: 'CANCELAR',
              items:
                  _coatingTypeItems.map((e) => MultiSelectItem(e, e)).toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (selectedItems) {
                _selectedTypeCoatingEdi
                    .clear(); // Limpa os valores selecionados anteriores, se houverem
                for (var item in selectedItems!) {
                  _selectedTypeCoatingEdi.add(
                      item); // Adiciona o valor selecionado à lista de valores
                }
                // Você pode fazer qualquer coisa com os valores selecionados aqui
                for (var value in _selectedTypeCoatingEdi) {
                  print('Item selecionado: $value');
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropDownField(
              labelText: 'Patologia',
              items: _patolgyItems,
              value: _selectPatolgyItems,
              onChanged: (newValue) {
                setState(() {
                  _selectPatolgyItems = newValue;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MultiSelectField(
              title: 'Tipo de patologia',
              buttonText: 'Selecione as patologias',
              cancelText: 'CANCELAR',
              items:
                  _typePatologyItems.map((e) => MultiSelectItem(e, e)).toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (selectedItems) {
                _selectedTypePatologyEdi
                    .clear(); // Limpa os valores selecionados anteriores, se houverem
                for (var item in selectedItems!) {
                  _selectedTypePatologyEdi.add(
                      item); // Adiciona o valor selecionado à lista de valores
                }
                // Você pode fazer qualquer coisa com os valores selecionados aqui
                for (var value in _selectedTypePatologyEdi) {
                  print('Item selecionado: $value');
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MultiSelectField(
              title: 'Cômodo',
              buttonText: 'Selecione os cômodos',
              cancelText: 'CANCELAR',
              items:
                  _convenientItems.map((e) => MultiSelectItem(e, e)).toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (selectedItems) {
                _selectedConvenientEdi
                    .clear(); // Limpa os valores selecionados anteriores, se houverem
                for (var item in selectedItems!) {
                  _selectedConvenientEdi.add(
                      item); // Adiciona o valor selecionado à lista de valores
                }
                // Você pode fazer qualquer coisa com os valores selecionados aqui
                for (var value in _selectedConvenientEdi) {
                  print('Item selecionado: $value');
                }
              },
            ),
          ],
        ),
        isActive: _currentStep >= 4,
        state: _currentStep >= 4 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(
          'CONDIÇÕES ESTRUTURAIS DA EDIFICAÇÃO',
          style: TextStyle(
            fontFamily: 'Prototype',
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          "FORRO",
          style: TextStyle(fontFamily: 'Prototype', fontSize: 14),
        ),
        content: Column(children: [
          DropDownField(
            labelText: 'Selecione uma tipologia',
            items: _typologyItemsLining,
            value: _selectTipologyItemsLining,
            onChanged: (newValue) {
              setState(() {
                _selectTipologyItemsLining = newValue;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DropDownField(
            labelText: 'Pé Solto',
            items: _footItems,
            value: _selectFootItems,
            onChanged: (newValue) {
              setState(() {
                _selectFootItems = newValue;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DropDownField(
            labelText: 'Patologia',
            items: _patologyItemsLining,
            value: _selectPatolgyItemsLining,
            onChanged: (newValue) {
              setState(() {
                _selectPatolgyItemsLining = newValue;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          MultiSelectField(
            title: 'Tipo de patologia',
            buttonText: 'Selecione as patologias',
            cancelText: 'CANCELAR',
            items: _typePatologyItemsLining
                .map((e) => MultiSelectItem(e, e))
                .toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (selectedItems) {
              _selectedTypePatologyLining
                  .clear(); // Limpa os valores selecionados anteriores, se houverem
              for (var item in selectedItems!) {
                _selectedTypePatologyLining.add(
                    item); // Adiciona o valor selecionado à lista de valores
              }
              // Você pode fazer qualquer coisa com os valores selecionados aqui
              for (var value in _selectedTypePatologyLining) {
                print('Item selecionado: $value');
              }
            },
          ),
        ]),
        isActive: _currentStep >= 5,
        state: _currentStep >= 5 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(
          'COBERTURA',
          style: TextStyle(
            fontFamily: 'Prototype',
            fontSize: 18,
          ),
        ),
        content: Column(children: [
          DropDownField(
            labelText: 'Possuí laje?',
            items: _slabItems,
            value: _selectedSlab,
            onChanged: (newValue) {
              setState(() {
                _selectedSlab = newValue;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DropDownField(
            labelText: 'Estrutura do telhado',
            items: _roofStructureItems,
            value: _selectedRoof,
            onChanged: (newValue) {
              setState(() {
                _selectedRoof = newValue;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DropDownField(
            labelText: 'Sistema de captação para águas pluviais',
            items: _collectionSystemItems,
            value: _selectedCollenction,
            onChanged: (newValue) {
              setState(() {
                _selectedCollenction = newValue;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DropDownField(
            labelText: 'Tipologia das telhas',
            items: _typologyTilesItem,
            value: _selectedTypologyTiles,
            onChanged: (newValue) {
              setState(() {
                _selectedTypologyTiles = newValue;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DropDownField(
            labelText: 'Patologia',
            items: _patologyItems,
            value: _selectedPatologyTiles,
            onChanged: (newValue) {
              setState(() {
                _selectedPatologyTiles = newValue;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          MultiSelectField(
            title: 'Tipo de patologia',
            buttonText: 'Selecione as patologias',
            cancelText: 'CANCELAR',
            items:
                _patologyTypeItems.map((e) => MultiSelectItem(e, e)).toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (selectedItems) {
              _selectedPatologyRoof
                  .clear(); // Limpa os valores selecionados anteriores, se houverem
              for (var item in selectedItems!) {
                _selectedPatologyRoof.add(
                    item); // Adiciona o valor selecionado à lista de valores
              }
              // Você pode fazer qualquer coisa com os valores selecionados aqui
              for (var value in _selectedPatologyRoof) {
                print('Item selecionado: $value');
              }
            },
          ),
        ]),
        isActive: _currentStep >= 6,
        state: _currentStep >= 6 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(
          'ASSINATURA',
          style: TextStyle(
            fontFamily: 'Prototype',
            fontSize: 18,
          ),
        ),
        content: Column(children: [
          TextField(
            controller: _resumo,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Insira um resumo do laudo',
              suffixIcon: const Icon(Icons.pending),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.red)),
              errorStyle: const TextStyle(height: 0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(height: 10),
          InputField(
            inputController: _nomeCompleto,
            textLabel: 'Nome completo',
            suffixWidget: const Icon(Icons.info),
            isRequired: true,
          ),
          const SizedBox(height: 10),
          InputField(
            inputController: _cargo,
            textLabel: 'Cargo atual',
            suffixWidget: const Icon(Icons.workspace_premium_rounded),
            isRequired: true,
          ),
          const SizedBox(height: 10),
          InputField(
            inputController: _rg,
            textLabel: 'Nº do RG',
            suffixWidget: const Icon(Icons.perm_identity),
            isRequired: true,
          ),
          const SizedBox(height: 10),
          InputField(
            inputController: _cpf,
            textLabel: 'Nº CPF/MF',
            suffixWidget: const Icon(Icons.numbers),
            isRequired: true,
          ),
        ]),
        isActive: _currentStep >= 7,
        state: _currentStep >= 7 ? StepState.complete : StepState.disabled,
      )
    ];
  }

  void _nextStep() {
    if (_currentStep < _formSteps.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Lógica para o último passo (opcional)
      // Por exemplo, exibir uma mensagem de conclusão ou realizar alguma ação adicional.
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context); // Navegar para a página inicial
    }
  }

  StepState _getStepState(int index) {
    if (index == _currentStep) {
      return StepState.editing;
    } else if (index < _currentStep) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stepper(
                        physics: const ScrollPhysics(),
                        currentStep: _currentStep,
                        onStepContinue: _nextStep,
                        onStepCancel: _previousStep,
                        steps: _formSteps,
                        // onStepTapped: ,
                        controlsBuilder:
                            (BuildContext context, ControlsDetails details) {
                          return Row(
                            children: <Widget>[
                              if (_currentStep ==
                                  0) // Botão "Voltar" no primeiro passo
                                TextButton(
                                  onPressed: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color.fromARGB(255, 173, 80, 85),
                                    ),
                                  ),
                                  child: const Text(
                                    'Voltar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              if (_currentStep >
                                  0) // Botão "Voltar" nos outros passos
                                TextButton(
                                  onPressed: details.onStepCancel,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color.fromARGB(255, 173, 80, 85),
                                    ),
                                  ),
                                  child: const Text(
                                    'Voltar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              const SizedBox(width: 10),
                              if (_currentStep <
                                  _formSteps.length -
                                      1) // Botão "Próximo" nos passos anteriores ao último
                                TextButton(
                                  onPressed: details.onStepContinue,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color.fromARGB(255, 12, 112, 60),
                                    ),
                                  ),
                                  child: const Text(
                                    'Próximo',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      if (_currentStep ==
                          _formSteps.length -
                              1) // Mostrar botão de geração do PDF no último passo
                        FractionallySizedBox(
                          widthFactor: 0.5,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 176, 37, 44)),
                            ),
                            onPressed: () {
                              final formData = FormData(
                                cod: _codController.text,
                                //form1
                                nomeEntrevistado: _nameController.text,
                                cpfEntrevistado:
                                    _cpfEntrevistadoController.text,
                                nomeProprietario: _proprietarioController.text,
                                cpfProprietario:
                                    _proprietarioCpfController.text,
                                contato: _contatoController.text,
                                endereco: _enderecoController.text,
                                cidade: _cidadeController.text,
                                bairro: _bairroController.text,
                                moradores: _moradoresController.text,
                                situacao: _selectedRented ?? '',
                                construcao: _construcaoController.text,
                                ocupacao: _ocupacaoController.text,
                                //form2
                                tipoImovel: _selectedType ?? '',
                                pavimento: _pavementController.text,
                                muro: _selectedWall ?? '',
                                padraoConstrutivo: _selectedConstructive ?? '',
                                idadeAparente: _selectedAge ?? '',
                                aberto: _selectedSituation ?? '',
                                qtdQuarto: _numberRooms.text,
                                qtdBanheiro: _numberBathrooms.text,
                                qtdSuite: _numberSuites.text,
                                garagem: _selectedGarage ?? '',
                                situacaoArea: _selectedArea ?? '',
                                //form3
                                tipologiaPiso: _selectedTypology.join(', '),
                                patologiaPiso: _selectedPatologyFloor ?? '',
                                tipoPatologiaPiso:
                                    _selectedTypePatologyFloor.join(', '),
                                //form 4
                                posivelIdentificar: _selectedIdentify ?? '',
                                conservacao: _selectedConservation ?? '',
                                patologiaSuperestrutura:
                                    _selectedPatologySuperstructure ?? '',
                                elemento: _selectedElements.join(', '),
                                tipoPatologiaSuperestrutura:
                                    _selectedTypePatologySuperstructure
                                        .join(', '),
                                //form 5
                                itensTipologiaEdi:
                                    _selectTipologyItemsEdi ?? '',
                                revestimento: _selectCoatingTypeItems ?? '',
                                itensRevestimento:
                                    _selectedTypeCoatingEdi.join(', '),
                                patologiaEdi: _selectPatolgyItems ?? '',
                                tipoPatologiaEdi:
                                    _selectedTypePatologyEdi.join(', '),
                                comodo: _selectedConvenientEdi.join(', '),
                                //form 6
                                tipologiaForro:
                                    _selectTipologyItemsLining ?? '',
                                peSolto: _selectFootItems ?? '',
                                patologiaForro: _selectPatolgyItemsLining ?? '',
                                tipoPatologiaForro:
                                    _selectedTypePatologyLining.join(', '),
                                //form 7
                                laje: _selectedSlab ?? '',
                                teto: _selectedRoof ?? '',
                                coleta: _selectedCollenction ?? '',
                                tipologiaTelha: _selectedTypologyTiles ?? '',
                                patologiaTelha: _selectedPatologyTiles ?? '',
                                tipoPatologiaTelha:
                                    _selectedPatologyRoof.join(', '),
                                //form 8
                                resumo: _resumo.text,
                                nomeCompleto: _nomeCompleto.text,
                                cargo: _cargo.text,
                                rg: _rg.text,
                                cpf: _cpf.text,
                              );
                              widget.onFormSubmitted(formData);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Gerar PDF'),
                                const SizedBox(width: 10),
                                Icon(Icons.picture_as_pdf), // Adiciona o ícone
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
