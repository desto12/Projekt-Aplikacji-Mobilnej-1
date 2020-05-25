/*

if (_formKey.currentState.validate()) {
if(DatabaseService().checkIsFree(widget.courtId, endDate, startDate) == true)
{
DatabaseService().addItem(widget.courtId, _name, startDate, endDate);
Navigator.of(context).pop();
}

else
return showDialog(
context: context,
builder: (BuildContext context) =>CupertinoAlertDialog(
title: Text('Wybierz inny termin!'),
content: Text('W tym czasie kort jest zajęty, wybierz inny termin'),
actions: <Widget>[
CupertinoDialogAction(
isDefaultAction: true,
child: Text('Ok'),
onPressed: (){
Navigator.of(context).pop();
},
)
],
),
);

}*/