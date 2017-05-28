﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UberFrba.Entidades
{
    class Automovil
    {
        public String patente {get; set;}
        public String marca {get; set;}
        public String modelo { get; set; }
        public String licencia { get; set; }
        public String rodado { get; set; }
        public int chofer { get; set; }
        public List<Turno> turnos { get; set; }

        public Automovil(String patente, String marca, String modelo, int chofer, List<Turno> turnos, String licencia, String rodado)
        {
            this.patente = patente;
            this.marca = marca;
            this.modelo = modelo;
            this.chofer = chofer;
            this.turnos = turnos;
            this.licencia = licencia;
            this.rodado = rodado;
        }

    }
}
