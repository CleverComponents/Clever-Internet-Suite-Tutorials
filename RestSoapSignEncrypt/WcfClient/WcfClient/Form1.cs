using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WcfClient
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnC2F_Click(object sender, EventArgs e)
        {
//https://stackoverflow.com/questions/22998847/wcf-protectionlevel
            RestSoap.RestSoapClient client = new RestSoap.RestSoapClient();
            RestSoap.Temperature cels = new RestSoap.Temperature();

            cels.Units = "C";
            cels.Value = Convert.ToDouble(edtCelsium.Text);

            RestSoap.Temperature  fahr = client.Celsius2Fahrenheit(cels);

            edtFahr.Text = fahr.Value.ToString();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            RestSoapSign.RestSoapSingClient client = new RestSoapSign.RestSoapSingClient();
            RestSoapSign.Temperature cels = new RestSoapSign.Temperature();

            cels.Units = "C";
            cels.Value = Convert.ToDouble(edtCelsium.Text);

            RestSoapSign.Temperature fahr = client.Celsius2Fahrenheit(cels);

            edtFahr.Text = fahr.Value.ToString();
        }
    }
}
