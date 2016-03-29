package chapters.chapter01;

public class Enums{

  public static void main(String[] args){}
  public void init(){
    enum Primitives {
      BYTE(8), SHORT(16), INT(32), LONG(64), FLOAT(32), DOUBLE(64);
      int bits;
      Primitives(int bits){this.bits=bits;}
    }
  }
}
