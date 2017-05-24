using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class Pair<T, U>
{
    public Pair()
    {
    }

    public Pair(T first, U second)
    {
        this.First = first;
        this.Second = second;
    }

    public T First { get; set; }
    public U Second { get; set; }
};

namespace LabWork
{
    class Program
    {
        static void Main(string[] args)
        {
            short w;
            short p;
            input(out w, out p);
            int[,] graph = readList(w, p);
            var ans = prim_algorithm(w, p, ref graph);
            printResults(ref ans, ref graph);
            Console.ReadKey();
        }

        static void input(out short w, out short p)
        {
            Console.WriteLine("Enter number of stations W and number of pipes P: ");
            string[] tokens = Console.ReadLine().Split();
            w = short.Parse(tokens[0]);
            p = short.Parse(tokens[1]);

            if (w <= 0 || w >= 2000 || p <= 0 || p >= 20000)
            {
                throw new System.Exception("Input parameters isn`t correct");
            }
        }

        static int[,] readList(short w, short p)
        {
            const int INF = 1000000017;
            int[,] graph = new int[w + 1, w + 1];
            for (int i = 0; i <= w; i++)
                for (int j = 0; j <= w; j++)
                    graph[i, j] = INF;

            Console.WriteLine("Enter pipes:");
            for (int i = 0; i < p; i++)
            {
                string[] tokens = Console.ReadLine().Split();
                short a = short.Parse(tokens[0]);
                short b = short.Parse(tokens[1]);
                short weight = short.Parse(tokens[2]);

                if (a <= 0 || a > w || b <= 0 || b > w)
                {
                    throw new System.Exception("Invalid edges");
                }

                graph[a, b] = weight;
                graph[b, a] = weight;
            }

            return graph;
        }

        static List<Pair<short, short>> prim_algorithm(short w, short p, ref int[,] graph)
        {
            const int INF = 1000000017;
            Boolean[] used = new Boolean[w + 1];
            for (int i = 0; i <= w; i++) used[i] = false;
            int[] min_e = new int[w + 1];
            for (int i = 0; i <= w; i++) min_e[i] = INF;
            short[] sel_e = new short[w + 1];
            for (int i = 0; i <= w; i++) sel_e[i] = -1;

            min_e[1] = 0;

            List<Pair<short, short>> ans = new List<Pair<short, short>>();

            for (short i = 0; i < w; i++)
            {
                short v = -1;
                for (short j = 1; j <= w; j++) {
                    if (!used[j] && (v == -1 || min_e[j] < min_e[v])) v = j;
                }

                if (min_e[v] == INF)
                {
                    throw new System.Exception("NO MST.");
                }

                used[v] = true;
                if (sel_e[v] != -1)
                {
                    ans.Add(new Pair<short, short>(sel_e[v], v));
                }

                for (int to = 1; to <= w; to++)
                {
                    if (graph[v, to] < min_e[to])
                    {
                        min_e[to] = graph[v, to];
                        sel_e[to] = v;
                    }
                } 
            }

            short lastAdded = ans[ans.Count - 1].Second;
            short from = ans[ans.Count - 1].First;
            int weidht = INF;
            short t = -1;

            for (short i = 1; i <= w; i++)
            {
                if (i == from) continue;
                if (weidht > graph[from, i])
                {
                    t = i;
                    weidht = graph[from, i];
                }
            }

            ans[ans.Count - 1].First = t;

            return ans;
        }

        static void printResults(ref List<Pair<short, short>> ans, ref int [,] g)
        {
            for (int i = 0, size = ans.Count; i < size; i++)
            {
                short from = ans[i].First;
                short to = ans[i].Second;
                Console.WriteLine(String.Format("{0} -> {1}: {2}", from, to, g[from, to]));
            } 
        }


    }
}
