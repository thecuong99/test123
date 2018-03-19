using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp2_LinkedList
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            ChangeByProperty danhsach1 = new ChangeByProperty();
            danhsach1.head = null;
            for (int i = 1; i <= 4; i++)
            {
                danhsach1.current = new ChangeByProperty.Node();
                danhsach1.current.item = i * 10;
                danhsach1.current.next = danhsach1.head;
                danhsach1.head = danhsach1.current;
                Console.WriteLine(danhsach1.current.item);
            }

            danhsach1.current = danhsach1.head;
            while (danhsach1.current != null)
            {
                Console.WriteLine(danhsach1.current.item);
                danhsach1.current = danhsach1.current.next;
            }
            Console.ReadLine();
            //Application.Run(new ChangeByProperty());
        }
    }
}
