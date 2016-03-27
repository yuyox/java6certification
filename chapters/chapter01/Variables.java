package chapters.chapter01;

public class Variables{

  public static void main(String[] args){}
  int var1;
  int var2;

  private void method1(){ 
    this.var1 = this.var2;
  }

  private void method2(){
    int var3;
    this.var1=var3;
  }

  private void method3(){
    int var4;
    var4=var1;
    var2=var3;
  }
}
