using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LabWork2
{
    public class Program
    {
        static void Main(string[] args)
        {
            var Series = new Series<Firgure>();
            Series.Changed += ChangeListener;
            Series.Add(new Parallelepiped(0, 0, 0));
            Series.Add(new Cone(1, 4));
            Series.Insert(1, new Cone(3, 1));
            Series.Add(new Parallelepiped(6, 5, 4) + new Parallelepiped(1, 2, 4));
            Series.Add(new Ball(37));
            Series.Delete(1);
            Console.WriteLine(Series);


            try
            {
                Series.Get(48);
            }
            catch (IndexOutOfRangeException)
            {
                Console.WriteLine("IndexOutOfRangeException");
            }

            try
            {
                Parallelepiped x = (Parallelepiped)Series.Get(0) / 0;
            }
            catch (DivideByZeroException)
            {
                Console.WriteLine("DivideByZeroException");
            }

            Console.WriteLine((Parallelepiped) Series.Get(0) == new Parallelepiped(1, 2, 50) * 0);
            Console.ReadKey();
        }

        public static void ChangeListener(ChangeType change)
        {
            switch (change)
            {
                case ChangeType.Add:
                    Console.WriteLine("Element added");
                    break;
                case ChangeType.Delete:
                    Console.WriteLine("Element deleted");
                    break;
                case ChangeType.Set:
                    Console.WriteLine("Element setted");
                    break;
                case ChangeType.Insert:
                    Console.WriteLine("Element inserted");
                    break;
            }
        }
    }

    /*
     *  interface Firgure
        {
            double square();
            double volume();
        }
     * 
     * */

    public abstract class Firgure
    {
        public abstract double square();
        public abstract double volume();

        public abstract override string ToString();
        public abstract override bool Equals(object obj);
        public abstract override int GetHashCode();
    }

    public class Parallelepiped : Firgure
    {
        public Parallelepiped(double a, double b, double c)
        {
            this.a = a;
            this.b = b;
            this.c = c;
        }

        public Parallelepiped() { }

        private double  a
        {
            get;
            set;
        }

        private double b
        {
            get;
            set;
        }

        private double c
        {
            get;
            set;
        }

        public override double square()
        {
            return 2 * (a * b + b * c + a * c);
        }

        public override double volume()
        {
            return a * b * c;
        }

        public static Parallelepiped operator+ (Parallelepiped x, Parallelepiped y)
        {
            Parallelepiped ans = new Parallelepiped();
            ans.a = x.a + y.a;
            ans.b = x.b + y.b;
            ans.c = x.c + y.c;
            return ans;
        }

        public static Parallelepiped operator- (Parallelepiped x, Parallelepiped y)
        {
            Parallelepiped ans = new Parallelepiped();
            ans.a = x.a - y.a;
            ans.b = x.b - y.b;
            ans.c = x.c - y.c;
            return ans;
        }

        public static Parallelepiped operator* (Parallelepiped x, double y)
        {
            Parallelepiped ans = new Parallelepiped();
            ans.a = x.a * y;
            ans.b = x.b * y;
            ans.c = x.c * y;
            return ans;
        }

        public static Parallelepiped operator/ (Parallelepiped x, double y)
        {
            if (y == 0.0) throw new DivideByZeroException();
            Parallelepiped ans = new Parallelepiped();
            ans.a = x.a / y;
            ans.b = x.b / y;
            ans.c = x.c / y;
            return ans;
        }

        public override bool Equals(object x)
        {
            Parallelepiped obj = (Parallelepiped)x;
            if (a == obj.a && b == obj.b && c == obj.c) return true;
            else return false;
        }

        public static bool operator== (Parallelepiped x, Parallelepiped y)
        {
            return Equals(x, y);
        }

        public static bool operator !=(Parallelepiped x, Parallelepiped y)
        {
            return !Equals(x, y);
        }

        public override int GetHashCode()
        {
            return a.GetHashCode() + 17 * b.GetHashCode() + 289 * c.GetHashCode();
        }

        public override string ToString()
        {
            return "Parallelepiped: (" + a.ToString() + "," +
                   b.ToString() + "," + c.ToString() + ")";
        }

    }

    public class Cone : Firgure
    {

        public Cone(double r, double h)
        {
            this.r = r;
            this.h = h;
        }

        public Cone() { }

        private double r
        {
            get;
            set;
        }

        private double h
        {
            get;
            set;
        }

        public override double square()
        {
            double l = Math.Sqrt(r * r + h * h);
            return Math.PI * r * l + Math.PI * r * r;
        }

        public override double volume()
        {
            return 1 / 3.0 * h * Math.PI * r * r;
        }

        public static Cone operator +(Cone x, Cone y)
        {
            Cone ans = new Cone();
            ans.r = x.r + y.r;
            ans.h = x.h + y.h;
            return ans;
        }

        public static Cone operator -(Cone x, Cone y)
        {
            Cone ans = new Cone();
            ans.r = x.r - y.r;
            ans.h = x.h - y.h;
            return ans;
        }

        public static Cone operator *(Cone x, double y)
        {
            Cone ans = new Cone();
            ans.r = x.r * y;
            ans.h = x.h * y;
            return ans;
        }

        public static Cone operator /(Cone x, double y)
        {
            if (y == 0.0) throw new DivideByZeroException();
            Cone ans = new Cone();
            ans.r = x.r / y;
            ans.h = x.h / y;
            return ans;
        }

        public override bool Equals(object x)
        {
            Cone obj = (Cone)x;
            if (h == obj.h && r == obj.r) return true;
            else return false;
        }

        public static bool operator ==(Cone x, Cone y)
        {
            return Equals(x, y);
        }

        public static bool operator !=(Cone x, Cone y)
        {
            return !Equals(x, y);
        }

        public override int GetHashCode()
        {
            return r.GetHashCode() + 17 * h.GetHashCode();
        }

        public override string ToString()
        {
            return "Cone: (" + h.ToString() + "," +
                   r.ToString()  + ")";
        }
    }

    public class Ball : Firgure
    {
        public Ball(double r)
        {
            this.r = r;
        }

        public Ball() { }

        private double r
        {
            get;
            set;
        }

        public override double square()
        {
            return 4 * Math.PI * r * r;
        }

        public override double volume()
        {
            return 4 / 3.0 * Math.PI * r * r * r;
        }

        public static Ball operator + (Ball x, Ball y)
        {
            Ball ans = new Ball();
            ans.r = x.r + y.r;
            return ans;
        }

        public static Ball operator - (Ball x, Ball y)
        {
            Ball ans = new Ball();
            ans.r = x.r - y.r;
            return ans;
        }

        public static Ball operator * (Ball x, double y)
        {
            Ball ans = new Ball();
            ans.r = x.r * y;
            return ans;
        }

        public static Ball operator / (Ball x, double y)
        {
            if (y == 0.0) throw new DivideByZeroException();
            Ball ans = new Ball();
            ans.r = x.r / y;
            return ans;
        }

        public override bool Equals(object x)
        {
            Ball obj = (Ball)x;
            if (r == obj.r) return true;
            else return false;
        }

        public static bool operator ==(Ball x, Ball y)
        {
            return Equals(x, y);
        }

        public static bool operator !=(Ball x, Ball y)
        {
            return !Equals(x, y);
        }

        public override int GetHashCode()
        {
            return r.GetHashCode();
        }

        public override string ToString()
        {
            return "Ball: (" +  r.ToString() + ")";
        }
    }

    public enum ChangeType { Add, Insert, Delete, Set }
    public delegate void ChangeHandler(ChangeType change);

    public class Series<T>
    {
        public List<T> Elements
        {
            get;
        }

        public event ChangeHandler Changed;

        public Series()
        {
            Elements = new List<T>();
        }

        public void Add(T v)
        {
            Elements.Add(v);
            if (Changed != null) Changed(ChangeType.Add);
        }

        public T Get(int index)
        {
            if (index < 0 || index >= Elements.Count) throw new IndexOutOfRangeException();
            return Elements[index];
        }

        public void Set(int index, T v)
        {
            if (index < 0 || index >= Elements.Count) throw new IndexOutOfRangeException();
            Elements[index] = v;
            if (Changed != null) Changed(ChangeType.Set);
        }

        public void Insert(int index, T v)
        {
            if (index < 0 || index >= Elements.Count) throw new IndexOutOfRangeException();
            Elements.Insert(index, v);
            if (Changed != null) Changed(ChangeType.Insert);
        }

        public void Delete(int index)
        {
            if (index < 0 || index >= Elements.Count) throw new IndexOutOfRangeException();
            Elements.RemoveAt(index);
            if (Changed != null) Changed(ChangeType.Delete);
        }

        public override string ToString()
        {
            return "[" + string.Join(", ", Elements) + "]";
        }
    }

    public class MyExeption : Exception
    {
        MyExeption(String str) : base("From MyExeption hello: " + str) {}
    }

    
}
