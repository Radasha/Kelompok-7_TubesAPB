import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mint APP - Kelompok 7',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline6: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.blue),
          bodyText2: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.black),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Keuangan - Kelompok 7'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAccountScreen(),
                    ),
                  );
                },
                child: Text('Create Account'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen(username: '', password: ''),
                    ),
                  );
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LoginScreen(username: username, password: password),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (!_isAlpha(value!)) {
                    return 'Username must contain only letters';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (!_isNumeric(value!)) {
                    return 'Password must contain only numbers';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createAccount,
                child: Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isAlpha(String str) {
    final alphaRegExp = RegExp(r'^[a-zA-Z]+$');
    return alphaRegExp.hasMatch(str);
  }

  bool _isNumeric(String str) {
    final numericRegExp = RegExp(r'^[0-9]+$');
    return numericRegExp.hasMatch(str);
  }
}

class LoginScreen extends StatefulWidget {
  final String username;
  final String password;

  LoginScreen({required this.username, required this.password});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _passwordController = TextEditingController(text: widget.password);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      if (username == widget.username && password == widget.password) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(username: username),
          ),
        );
      } else {
        _showErrorDialog('Invalid username or password');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (!_isAlpha(value!)) {
                    return 'Username must contain only letters';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (!_isNumeric(value!)) {
                    return 'Password must contain only numbers';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isAlpha(String str) {
    final alphaRegExp = RegExp(r'^[a-zA-Z]+$');
    return alphaRegExp.hasMatch(str);
  }

  bool _isNumeric(String str) {
    final numericRegExp = RegExp(r'^[0-9]+$');
    return numericRegExp.hasMatch(str);
  }
}

class HomeScreen extends StatefulWidget {
  final String username;

  HomeScreen({required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> _transactions = [];

  void _addTransaction(Transaction transaction) {
    setState(() {
      _transactions.add(transaction);
    });
  }

  void _handleTransfer(Transaction transaction) {
    setState(() {
      _transactions.add(transaction);
    });
  }

  void _handleRequestFunds(Transaction transaction) {
    setState(() {
      _transactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double totalBalance =
        _transactions.fold(0, (sum, item) => sum + item.amount);

    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Keuangan - Kelompok 7'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProfileScreen(username: widget.username),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Total Saldo',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Rp${totalBalance.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  _buildDashboardItem(Icons.send, 'Transfer', Colors.orange,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransferScreen(
                          onTransfer: _handleTransfer,
                        ),
                      ),
                    );
                  }),
                  _buildDashboardItem(
                      Icons.request_page, 'Minta Dana', Colors.blue, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RequestFundsScreen(
                          onRequestFunds: _handleRequestFunds,
                        ),
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'History Transaksi ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              if (_transactions.isEmpty)
                Text(
                  'Belum ada transaksi',
                  style: TextStyle(fontSize: 14),
                )
              else
                Column(
                  children: _transactions.map((transaction) {
                    return Card(
                      child: ListTile(
                        leading: Icon(transaction.icon),
                        title: Text(transaction.title),
                        subtitle: Text(transaction.date),
                        trailing: Text(
                          'Rp${transaction.amount.toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTransactionScreen(
                        onAddTransaction: _addTransaction,
                      ),
                    ),
                  );
                },
                child: Text('Tambah Transaksi'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoodbyeScreen(),
                    ),
                  );
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardItem(
      IconData icon, String label, Color color, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final String username;

  ProfileScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Username: $username',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class GoodbyeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goodbye'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.thumb_up,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'Anda telah berhasil logout.',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final IconData icon;
  final String title;
  final double amount;
  final String date;
  final TransactionType type;

  Transaction({
    required this.icon,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
  });
}

enum TransactionType {
  income,
  expense,
}

class AddTransactionScreen extends StatefulWidget {
  final Function(Transaction) onAddTransaction;

  AddTransactionScreen({required this.onAddTransaction});

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  TransactionType _transactionType = TransactionType.income;

  void _addTransaction() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (title.isNotEmpty && amount > 0) {
      final transaction = Transaction(
        icon: _transactionType == TransactionType.income
            ? Icons.arrow_downward
            : Icons.arrow_upward,
        title: title,
        amount: amount,
        date: DateTime.now().toString(),
        type: _transactionType,
      );

      widget.onAddTransaction(transaction);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Jumlah Saldo'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<TransactionType>(
              value: _transactionType,
              onChanged: (TransactionType? value) {
                setState(() {
                  _transactionType = value!;
                });
              },
              items: TransactionType.values.map((TransactionType type) {
                return DropdownMenuItem<TransactionType>(
                  value: type,
                  child: Text(type == TransactionType.income
                      ? 'Pemasukan'
                      : 'Pengeluaran'),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTransaction,
              child: Text('Tambah'),
            ),
          ],
        ),
      ),
    );
  }
}

class TransferScreen extends StatefulWidget {
  final Function(Transaction) onTransfer;

  TransferScreen({required this.onTransfer});

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _transfer() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (title.isNotEmpty && amount > 0) {
      final transaction = Transaction(
        icon: Icons.send,
        title: title,
        amount: amount,
        date: DateTime.now().toString(),
        type: TransactionType.expense,
      );

      widget.onTransfer(transaction);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Bank'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Nama Penerima'),
            ),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Jumlah Saldo'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _transfer,
              child: Text('Transfer'),
            ),
          ],
        ),
      ),
    );
  }
}

class RequestFundsScreen extends StatefulWidget {
  final Function(Transaction) onRequestFunds;

  RequestFundsScreen({required this.onRequestFunds});

  @override
  _RequestFundsScreenState createState() => _RequestFundsScreenState();
}

class _RequestFundsScreenState extends State<RequestFundsScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _requestFunds() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (title.isNotEmpty && amount > 0) {
      final transaction = Transaction(
        icon: Icons.request_page,
        title: title,
        amount: amount,
        date: DateTime.now().toString(),
        type: TransactionType.income,
      );

      widget.onRequestFunds(transaction);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minta Dana'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Minta Cepat'),
            ),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Jumlah Saldo '),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestFunds,
              child: Text('Minta Dana'),
            ),
          ],
        ),
      ),
    );
  }
}
