

/**
 * @author nhphung
 */
package exercise

trait FP {

// Q1
  //def recLstSquare(n:Int) :List[Int] = if(n==1) return List(1) else (n*n)::recLstSquare(n-1)
  def recLstSquare(n:Int) :List[Int] = if(n==1) List(1) else recLstSquare(n-1):+(n*n)
  def hello() = {
			println("Hello, World! ")
  }
  //recHelpLstSquare(3,5)=> List[9,16,25]
  //def recHelpLstSquare(n1:Int,n2:Int):List[Int] = if(n1==n2) (n*n) else recHelpLstSquare(n1+1,n2:Int)
  def recHelpLstSquare(n1:Int,n2:Int):List[Int] = if(n1==n2) List(n1*n1) else n1*n1::recHelpLstSquare(n1+1,n2)
  
  //def higLstSquare(n:Int) :List[Int] = (1 to n).map((x:Int) => x*x)        \\((x:Int) => x*x)
  def higLstSquare(n:Int) :List[Int] = {
	return(1 to n).map(n => n*n).toList
  }
  
// Q2
  def recPow(x:Double,n:Int):Double = {
	if(n==0) (1)
	else x*recPow(x, (n-1))
  }
  //toList.foldLeft
  def higPow(x:Double,n:Int):Double = {
	def power(exp:Double) = (x:Double)=>math.pow(x,exp)
	val a = power(n)
	return a(x)
  }
  def higPow2(x:Double,n:Int):Double = {
	(1 to n).toList.foldLeft(1.0)((a,b)=>a*x)
  }

// Q3
  def recAppend(a:List[Int],b:List[Int]):List[Int] = a match {
	case List() => b
	case x::y => x :: recAppend(y,b)
  }
  def recReverse(a:List[Int]):List[Int] = a match {
	case List() => a
	case x::b => recReverse(b):::List(x)
  }
  def higAppend(a:List[Int],b:List[Int]) = {
	b.foldLeft(a)((x,y)=>x ++ List(y))
  }
  def higReverse(a:List[Int]):List[Int] = {
	a.foldLeft(List[Int]()) ((x, y)=>y::x)
  }

// Q4
  def recLessThan(n:Int,lst:List[Int]):List[Int] = {
	if (lst.isEmpty) return List.empty    //List()
	if (lst.head < n)
		return lst.head::recLessThan(n, lst.tail)
	recLessThan(n, lst.tail)
  }
  def higLessThan(n:Int,lst:List[Int]) = {
	lst.filter(x => x < n)
  }


// Q5
  case class A(n:String,v:Int)
  case class B(x:Int,y:A)
  def lookup[T](n:String,lst:List[T],f:T=>String):Option[T] = {
	val l = lst.filter(x => f(x).eq(n))
	if(l.isEmpty) return Option.empty
	Option(l.head)
  }
}


object Exercise {
  def main(args: Array[String]): Unit = print("a")
}

class Rational(n:Int, d:Int){
    require(d != 0)
    
    private val g = gcd(n.abs, d.abs)
    private def gcd(a: Int, b: Int): Int = 
                  if (b == 0) a else gcd(b, a % b) 
    val numer = n / g
    val denom = d / g
    
    def this(n: Int) = this(n, 1)
    
	def this() = this(0, 1)  //Exercise 1a  this(n) = this(n,1) => this(0)
	
	def +(inputX:Int):Rational = new Rational(inputX) + this   //Exercise 1b
	
	def *(inputX:Rational):Rational = new Rational ( numer * inputX.numer, denom * inputX.denom) //Exercise 1c
	
	def *(inputX:Int):Rational = this * new Rational(inputX) //Exercise 1d
	
    def + (that: Rational): Rational =
        new Rational(
             numer * that.denom + that.numer * denom,
             denom * that.denom
        )
    
    override def toString = numer +"/"+ denom
}


abstract class Element{
	def contents:Array[String]	//nobody:abstract
	val height = contents.length
	//def height = contents.length
	val width = if(height==0)0 else contents(0).length
	//def width = if(height==0)0 else contents(0).length
}

class ArrayElement(conts:Array[String]) extends Element{
	def contents:Array[String]=conts
}

class LineElement(s:String) extends ArrayElement(Array(s)){
	override val width = s.length
	//override def width :Int = s.length
	override val height = 1
	//override def height = 1
}