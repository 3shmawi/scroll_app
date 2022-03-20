abstract class BankStates {}

class BankAccountInitialState extends BankStates {}

class CreateDatabaseSuccessState extends BankStates {}

class CreateDatabaseErrorState extends BankStates {}

class GetDataFromDatabaseSuccessState extends BankStates {}

class GetDataFromDatabaseErrorState extends BankStates {}

class UpdateDatabaseSuccessState extends BankStates {}

class UpdateDatabaseErrorState extends BankStates {}

class WithdrawSuccessState extends BankStates {}

class DepositSuccessState extends BankStates {}
class ChangeValueSuccessState extends BankStates {}
