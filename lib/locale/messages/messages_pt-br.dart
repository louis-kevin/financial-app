import '../locale_keys.dart';

var welcomePage = <String, String>{
  WelcomePageTextKeys.title: "Bem vindo ao Financial",
  WelcomePageTextKeys.subtitle:
      'O melhor jeito de gerenciar suas contas e prever seus gastos em um simples toque',
  WelcomePageTextKeys.continueWith: 'Continuar com:',
  WelcomePageTextKeys.btnEmail: 'EMAIL',
  WelcomePageTextKeys.btnFacebook: 'FACEBOOK'
};

var authPage = <String, String>{
  AuthPageTextKeys.tabSignInTitle: 'LOGIN',
  AuthPageTextKeys.tabSignUpTitle: 'CADASTRO',
  AuthPageTextKeys.forgotPassword: 'ESQUECI A SENHA',
  AuthPageTextKeys.btnEnter: 'ENTRAR',
  AuthPageTextKeys.btnSignUp: 'CADASTRAR',
  AuthPageTextKeys.btnFacebook: 'FACEBOOK',
  AuthPageTextKeys.pageForgotPasswordTitle: 'Esqueceu a senha?',
  AuthPageTextKeys.pageForgotPasswordSubtitleOne:
      'Sem problema, vamos resolver isso!',
  AuthPageTextKeys.pageForgotPasswordSubtitleSecond:
      'Rapidinho enviaremos um email para você redefinir sua senha.',
  AuthPageTextKeys.labelEmailInput: 'Insira seu email cadastrado',
  AuthPageTextKeys.btnRecoveryPassword: 'RECUPERAR MINHA SENHA',
};

var labelInputs = {
  LabelTextKeys.name: 'Nome',
  LabelTextKeys.email: 'Email',
  LabelTextKeys.password: 'Senha',
  LabelTextKeys.amount: 'Valor',
  LabelTextKeys.color: 'Cor',
};

var money = {
  MoneyTextKeys.decimalSeparator: ',',
  MoneyTextKeys.thousandSeparator: '.',
  MoneyTextKeys.leftSymbol: 'R\$ ',
};

var settingsPage = {
  SettingsPageTextKeys.btnNext: 'PRÓXIMO',
  SettingsPageTextKeys.firstTitle: 'Vamos nos conhecer',
  SettingsPageTextKeys.firstSubtitle:
      'Qual dia você geralmente recebe seu salário?',
  SettingsPageTextKeys.selectionWorkDay: 'dia útil',
  SettingsPageTextKeys.selectionAllDays: 'dia corrido',
  SettingsPageTextKeys.secondTitle: 'Salário em finai de semana e feriado',
  SettingsPageTextKeys.secondSubtitle:
      'Quando o %sᵒ %s cai em um final de semana ou feriado, o que acontece?',
  SettingsPageTextKeys.selectionDayAfter: 'Recebo no próximo dia útil',
  SettingsPageTextKeys.selectionDayBefore:
      'Recebo no dia anterior mais próximo',
  SettingsPageTextKeys.calendarDay: 'dia corrido',
  SettingsPageTextKeys.businessDay: 'dia útil',
  SettingsPageTextKeys.thirdTitle: 'Ainda sobre salário',
  SettingsPageTextKeys.thirdSubtitle:
      "Para prever algumas coisas e monstarmos alguns gráficos, presicamos saber: quanto você ganha em média? \nTudo bem não querer responder",
  SettingsPageTextKeys.fourthTitle: 'Sobre feriados',
  SettingsPageTextKeys.fourthSubtitle: 'Você tira folga aos feriados?',
  SettingsPageTextKeys.btnYes: 'Sim',
  SettingsPageTextKeys.btnNo: 'Não',
};

var homePage = {
  HomePageTextKeys.tabTotals: 'Totais',
  HomePageTextKeys.tabBills: 'Gastos',
};

var summaryTabPage = {
  SummaryTabPageTextKeys.titleMoneyPerDayCard:
      'GASTO ADICIONAL PERMITIDO POR DIA',
  SummaryTabPageTextKeys.titleTotalDebitCard: 'TOTAL RESTANTE NO DÉBITO',
  SummaryTabPageTextKeys.titleTotalCreditCard: 'TOTAL RESTANDO NO CRÉDITO',
  SummaryTabPageTextKeys.titleDaysUntilNextIncomeCard:
      'DIAS ATÉ O PRÓXIMO PAGAMENTO',
  SummaryTabPageTextKeys.holidays: 'FERIADOS',
  SummaryTabPageTextKeys.businessDays: 'DIAS ÚTEIS',
  SummaryTabPageTextKeys.weekendDays: 'FINAIS DE SEMANA',
};

var billTabPage = {
  BillsTabPageTextKeys.btnCreateAccount: 'CRIAR CONTA',
  BillsTabPageTextKeys.btnCreateBill: 'CRIAR GASTO',
  BillsTabPageTextKeys.titleToPayCard: 'A PAGAR',
  BillsTabPageTextKeys.titleAccountMoneyCard: 'EM CONTA',
  BillsTabPageTextKeys.titleOnceList: 'Único',
  BillsTabPageTextKeys.titleDailyList: 'Diário',
  BillsTabPageTextKeys.titleMonthlyList: 'Mensal',
};

var billFormPage = {
  BillFormPageTextKeys.addTitle: 'Adicionar Gasto',
  BillFormPageTextKeys.editTitle: 'Editar Gasto',
  BillFormPageTextKeys.selectionOnce: 'Único',
  BillFormPageTextKeys.selectionDaily: 'Diária',
  BillFormPageTextKeys.selectionMonthly: 'Mensal',
  BillFormPageTextKeys.labelPaymentDay: 'Data de pagamento',
  BillFormPageTextKeys.btnSave: 'SALVAR',
};

var accountsPage = {
  AccountsPageTextKeys.title: 'Contas',
};

var accountPage = {
  AccountPageTextKeys.addTitle: 'Adicionar conta',
  AccountPageTextKeys.editTitle: 'Editar conta',
  AccountPageTextKeys.labelColor: 'Cor',
  AccountPageTextKeys.titleSelectColor: 'Selecione uma cor',
  AccountPageTextKeys.btnSave: 'SALVAR',
  AccountPageTextKeys.btnDelete: 'DELETAR',
};

var profilePage = {
  ProfilePageTextKeys.title: 'Perfil',
  ProfilePageTextKeys.btnSave: 'SALVAR',
};

var menuPage = {
  MenuPageTextKeys.menuAccountsItem: 'Contas',
  MenuPageTextKeys.menuProfileItem: 'Perfil',
  MenuPageTextKeys.menuSettingsItem: 'Configurações',
  MenuPageTextKeys.aboutUs: 'Sobre nós',
  MenuPageTextKeys.privacyPolicies: 'Políticas de Privacidade',
  MenuPageTextKeys.logout: 'Sair',
};

var accountMoneyUpdate = {
  AccountMoneyUpdatePageTextKeys.title: 'Atualizar Dinheiro em Conta',
  AccountMoneyUpdatePageTextKeys.btnSave: 'ATUALIZAR',
};

var dialogs = {
  DialogsTextKeys.accountRemovalTitle: 'Deseja mesmo remover esta conta?',
  DialogsTextKeys.btnYes: 'SIM',
  DialogsTextKeys.btnNo: 'NÃO',
  DialogsTextKeys.btnCancel: 'CANCELAR',
};

var dateTime = {DateFormatKey.dateFormat: 'dd-MM'};

var ptBrMessages = <String, String>{
  ...money,
  ...labelInputs,
  ...welcomePage,
  ...authPage,
  ...settingsPage,
  ...homePage,
  ...summaryTabPage,
  ...billTabPage,
  ...billFormPage,
  ...accountsPage,
  ...accountPage,
  ...profilePage,
  ...menuPage,
  ...accountMoneyUpdate,
  ...dialogs,
  ...dateTime
};
