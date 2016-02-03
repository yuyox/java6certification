package chapters.chapter01;

public class ClassInheritance{
  public static void main(String [] args){
  }
  static String returnName(){
  return "Bob";
  }
}

class SubClass implements ClassInheritance{
  public static void main(String [] args){
  returnName();
  }
}
