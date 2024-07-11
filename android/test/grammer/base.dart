void main(){
  int age = 2;
  double weight = 4.5;
  double a = 4.5;
  double b = 3.5;
  double c = 2.5;

  String hello = 'hello Flutter!';
  
  double avg = (a+b+c)/3;
  print('平均值是：$avg，总和是：${a+b+c}, bmi=${bmi(1, 3)}');

  Set<int> numSet = {1,9,9,4};
  numSet.add(6);
  print(numSet);
}

double bmi(double height, double weight ){
  return height * weight;
}

