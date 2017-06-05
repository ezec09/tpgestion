﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using UberFrba.Entidades;
using UberFrba.SQL;

namespace UberFrba.Abm_Chofer
{
    public partial class listadoSeleccionBajaChofer : Form
    {
        public listadoSeleccionBajaChofer()
        {
            InitializeComponent();
            this.buttonLimpiar_Click(null, null);
        }

        private void buttonLimpiar_Click(object sender, EventArgs e)
        {
            textBoxNombre.Clear();
            textBoxApellido.Clear();
            textBoxDNI.Clear();
            this.dataGridView1.DataSource = new BindingSource(new BindingList<Chofer>(new SqlChoferes().getChoferes(15)),null);
        }

        private void buttonBuscar_Click(object sender, EventArgs e)
        {
            String busqueda = "";
            if (textBoxNombre.TextLength > 0)
            {
                busqueda = busqueda + "Chofer_Nombre LIKE '%" + textBoxNombre.Text + "%'";
            }
            if (textBoxApellido.TextLength > 0)
            {
                if (!busqueda.Equals(""))
                {
                    busqueda = busqueda + " AND ";
                }
                busqueda = busqueda + "Chofer_Apellido LIKE '%" + textBoxApellido.Text + "%'";
            }

            if (textBoxDNI.TextLength > 0)
            {
                if (!busqueda.Equals(""))
                {
                    busqueda = busqueda + " AND ";
                }
                busqueda = busqueda + "Chofer_DNI LIKE '%" + textBoxDNI.Text + "%'";
            }
            busqueda = busqueda.Trim();
            if (busqueda.Equals(""))
            {
                MessageBox.Show("Ningun campo completado");
                return;
            }
            this.dataGridView1.DataSource = new BindingSource(new BindingList<Chofer>(new SqlChoferes().getChoferes(busqueda)), null);
        }

        private void buttonCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void seleccionChofer(object sender, EventArgs e)
        {
            new modificacionChofer(this.dataGridView1.SelectedRows[0].DataBoundItem as Chofer).Show();
            this.Close();
        }
    }
}
