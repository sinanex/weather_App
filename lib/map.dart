void main(){
  Map<String,dynamic> map = {
  'sinan':18,
  'mubashir':18,
};


map.forEach((key,value){
  if(key == 'sinan'){
    print("$key $value");
  }
});

}