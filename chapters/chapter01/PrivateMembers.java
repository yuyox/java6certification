package chapters.chapter01;

public class PrivateMembers{
  public int member1;
  private int getMember1(){return member1;}
  public static void main(String [] args){}
}

private class PublicMembers extends PrivateMembers{
  private int member2;
  private int getMember2(){return member2;}
  public static void main(String [] args){
    PublicMembers pm = new PublicMembers();
    pm.getMember1();  
    pm.getMember2();  
  }
}
