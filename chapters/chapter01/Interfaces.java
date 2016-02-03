package chapters.chapter01;

public class Interfaces implements Interface1{
  int size3=3;
  public static void main(String [] args){}
  int getSize1(){return size1;}
  private int getSize2(){return size2;}
  public int getSize3(){return size3;}
}



interface Interface1{
  public final static int size1=1;
  public final static int size2;
  int getSize1();
  int getSize2();
  public abstract int getSize3();
}
