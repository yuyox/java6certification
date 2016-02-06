package chapters.chapter01;

public class FinalArgument{
  int variableX;
  public static void main(String [] args){}
  private void setX(final int x){
    x = x + 1;
    variableX = x;
  }
}
