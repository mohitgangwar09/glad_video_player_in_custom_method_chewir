import 'package:flutter/material.dart';

class CowsAndYields extends StatefulWidget {
  const CowsAndYields({super.key});

  @override
  CowsAndYieldsState createState() => CowsAndYieldsState();
}

class CowsAndYieldsState extends State<CowsAndYields> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  static List<String> productionList = [""];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('Cows And Yield'),),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      hintText: 'Enter your Farm name'
                  ),

                ),
              ),
              const SizedBox(height: 20,),
              const Text('Add Production', style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 16),),
              ..._getProduction(),
              const SizedBox(height: 40,),
              TextButton(
                onPressed: (){
                  // if(_formKey.currentState.validate()){
                    _formKey.currentState?.save();
                    print(productionList);
                  // }
                },
                child: const Text('Submit'),
                // color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addRemoveButton(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          productionList.insert(0, "");
        }
        else {
          productionList.removeAt(index);
        }
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove, color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _getProduction(){
    List<Widget> friendsTextFieldsList = [];
    for(int i=0; i<productionList.length; i++){
      friendsTextFieldsList.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(child: ProductionTextField(i)),
                const SizedBox(width: 16,),
                // we need add button at last friends row only
                _addRemoveButton(i == productionList.length-1, i),
              ],
            ),
          )
      );
    }
    return friendsTextFieldsList;
  }
}

class ProductionTextField extends StatefulWidget {
  final int index;
  const ProductionTextField(this.index, {super.key});

  @override
  State<ProductionTextField> createState() => _ProductionTextFieldState();
}

class _ProductionTextFieldState extends State<ProductionTextField> {

  late TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = CowsAndYieldsState.productionList[widget.index]
          ?? '';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => CowsAndYieldsState.productionList[widget.index] = v,
      decoration: const InputDecoration(
          hintText: 'Enter your Milk Production Details'
      ),

    );
  }
}





