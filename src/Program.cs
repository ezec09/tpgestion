﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;
using UberFrba.SQL;

namespace UberFrba
{
    static class Program
    { 
        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        /// 
        public static DateTime dia;
        [STAThread]
        static void Main()
        {
            dia = DateTime.Parse(ConfigurationManager.AppSettings["Dia"]);
            SqlGeneral.inicializar();
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new login());
          
        }
    }
}
