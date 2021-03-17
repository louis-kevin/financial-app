import '../locale_keys.dart';

var welcomePage = <String, String>{
  WelcomePageTextKeys.title: "Welcome to Financial",
  WelcomePageTextKeys.subtitle:
      'The best app to manage your finances in one single click',
  WelcomePageTextKeys.continueWith: 'Start with:',
  WelcomePageTextKeys.btnEmail: 'EMAIL',
  WelcomePageTextKeys.btnFacebook: 'FACEBOOK'
};

var authPage = <String, String>{
  AuthPageTextKeys.tabSignInTitle: 'LOGIN',
  AuthPageTextKeys.tabSignUpTitle: 'REGISTER',
  AuthPageTextKeys.forgotPassword: 'FORGOT THE PASSWORD',
  AuthPageTextKeys.btnEnter: 'SIGN IN',
  AuthPageTextKeys.btnSignUp: 'SIGN UP',
  AuthPageTextKeys.btnFacebook: 'FACEBOOK',
  AuthPageTextKeys.pageForgotPasswordTitle: 'FORGOT PASSWORD?',
  AuthPageTextKeys.pageForgotPasswordSubtitleOne:
      'No problem, we can fix that!',
  AuthPageTextKeys.pageForgotPasswordSubtitleSecond:
      'We\'ll send to you a email to recover your password',
  AuthPageTextKeys.labelEmailInput: 'Your email goes where',
  AuthPageTextKeys.btnRecoveryPassword: 'RECOVER MY PASSWORD',
};

var labelInputs = {
  LabelTextKeys.name: 'Name',
  LabelTextKeys.email: 'Email',
  LabelTextKeys.password: 'Password',
  LabelTextKeys.amount: 'Amount',
  LabelTextKeys.color: 'Color',
};

var money = {
  MoneyTextKeys.decimalSeparator: '.',
  MoneyTextKeys.thousandSeparator: ',',
  MoneyTextKeys.leftSymbol: '\$ ',
};

var settingsPage = {
  SettingsPageTextKeys.btnNext: 'NEXT',
  SettingsPageTextKeys.firstTitle: 'Let\'s know each other',
  SettingsPageTextKeys.firstSubtitle:
      'Which day do you usually receive your salary?',
  SettingsPageTextKeys.selectionWorkDay: 'business days',
  SettingsPageTextKeys.selectionAllDays: 'calendar days',
  SettingsPageTextKeys.secondTitle: 'Salary in weekends and holidays',
  SettingsPageTextKeys.secondSubtitle:
      'When the %sᵒ %s ends up in a weekend or holidays, what happens?',
  SettingsPageTextKeys.selectionDayAfter: 'I receive in the next business day',
  SettingsPageTextKeys.selectionDayBefore: 'I receive in the upfront day',
  SettingsPageTextKeys.calendarDay: 'calendar day',
  SettingsPageTextKeys.businessDay: 'business day',
  SettingsPageTextKeys.thirdTitle: 'Still about income',
  SettingsPageTextKeys.thirdSubtitle:
      "To predict some things and set up some graphics, we need to know: how much do you earn on average? \nOkay not wanting to answer",
  SettingsPageTextKeys.fourthTitle: 'About holidays',
  SettingsPageTextKeys.fourthSubtitle: 'Do you rest on holidays?',
  SettingsPageTextKeys.btnYes: 'Yes',
  SettingsPageTextKeys.btnNo: 'No',
};

var homePage = {
  HomePageTextKeys.tabTotals: 'Summary',
  HomePageTextKeys.tabBills: 'Bills',
};

var summaryTabPage = {
  SummaryTabPageTextKeys.titleMoneyPerDayCard:
      'ADDITIONAL SPENDING ALLOWED PER DAY',
  SummaryTabPageTextKeys.titleTotalDebitCard: 'TOTAL REMAINING DEBT',
  SummaryTabPageTextKeys.titleTotalCreditCard: 'TOTAL REMAINING CREDIT',
  SummaryTabPageTextKeys.titleDaysUntilNextIncomeCard: 'DAYS UNTIL NEXT INCOME',
  SummaryTabPageTextKeys.holidays: 'HOLIDAYS',
  SummaryTabPageTextKeys.businessDays: 'BUSINESS DAYS',
  SummaryTabPageTextKeys.weekendDays: 'WEEKEND DAYS',
};

var billTabPage = {
  BillsTabPageTextKeys.btnCreateAccount: 'CREATE ACCOUNT',
  BillsTabPageTextKeys.btnCreateBill: 'CREATE BILL',
  BillsTabPageTextKeys.titleToPayCard: 'TO PAY',
  BillsTabPageTextKeys.titleAccountMoneyCard: 'ACCOUNT MONEY',
  BillsTabPageTextKeys.titleOnceList: 'Once',
  BillsTabPageTextKeys.titleDailyList: 'Daily',
  BillsTabPageTextKeys.titleMonthlyList: 'Monthly',
};

var billFormPage = {
  BillFormPageTextKeys.addTitle: 'Add Bill',
  BillFormPageTextKeys.editTitle: 'Edit Bill',
  BillFormPageTextKeys.selectionOnce: 'Once',
  BillFormPageTextKeys.selectionDaily: 'Daily',
  BillFormPageTextKeys.selectionMonthly: 'Monthly',
  BillFormPageTextKeys.labelPaymentDay: 'Payment Day',
  BillFormPageTextKeys.btnSave: 'SAVE',
};

var accountsPage = {
  AccountsPageTextKeys.title: 'Accounts',
};

var accountPage = {
  AccountPageTextKeys.addTitle: 'Add Account',
  AccountPageTextKeys.editTitle: 'Edit Account',
  AccountPageTextKeys.labelColor: 'Color',
  AccountPageTextKeys.titleSelectColor: 'Pick a color',
  AccountPageTextKeys.btnSave: 'SAVE',
  AccountPageTextKeys.btnDelete: 'REMOVE',
};

var profilePage = {
  ProfilePageTextKeys.title: 'Profile',
  ProfilePageTextKeys.btnSave: 'SAVE',
};

var menuPage = {
  MenuPageTextKeys.menuAccountsItem: 'Accounts',
  MenuPageTextKeys.menuProfileItem: 'Profile',
  MenuPageTextKeys.menuSettingsItem: 'Settings',
  MenuPageTextKeys.aboutUs: 'About Us',
  MenuPageTextKeys.privacyPolicies: 'Privacy Policies',
  MenuPageTextKeys.logout: 'Logout',
};

var accountMoneyUpdate = {
  AccountMoneyUpdatePageTextKeys.title: 'Update Account Money',
  AccountMoneyUpdatePageTextKeys.btnSave: 'UPDATE',
};

var dialogs = {
  DialogsTextKeys.accountRemovalTitle:
      'Do you really want to remove this account?',
  DialogsTextKeys.btnYes: 'YES',
  DialogsTextKeys.btnNo: 'NO',
  DialogsTextKeys.btnCancel: 'CANCEL',
};

var dateTime = {DateFormatKey.dateFormat: 'MM/dd'};

var enMessages = <String, String>{
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
