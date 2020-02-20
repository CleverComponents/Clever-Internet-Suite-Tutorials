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
            if (cbTransport.Checked)
            {
                RestSoap.RestSoapClient client = new RestSoap.RestSoapClient();
                RestSoap.Temperature cels = new RestSoap.Temperature();

                cels.Units = "C";
                cels.Value = Convert.ToDouble(edtCelsium.Text);

                RestSoap.Temperature fahr = client.Celsius2Fahrenheit(cels);

                edtFahr.Text = fahr.Value.ToString();
            }
            else if (cbSign.Checked)
            {
                RestSoapSign.RestSoapSignClient client = new RestSoapSign.RestSoapSignClient();
                RestSoapSign.Temperature cels = new RestSoapSign.Temperature();

                cels.Units = "C";
                cels.Value = Convert.ToDouble(edtCelsium.Text);

                RestSoapSign.Temperature fahr = client.Celsius2Fahrenheit(cels);

                edtFahr.Text = fahr.Value.ToString();
            }
            else if (cbEncrypt.Checked)
            {
                RestSoapSignEncrypt.RestSoapSignEncryptClient client = new RestSoapSignEncrypt.RestSoapSignEncryptClient();
                RestSoapSignEncrypt.Temperature cels = new RestSoapSignEncrypt.Temperature();

                cels.Units = "C";
                cels.Value = Convert.ToDouble(edtCelsium.Text);

                RestSoapSignEncrypt.Temperature fahr = client.Celsius2Fahrenheit(cels);

                edtFahr.Text = fahr.Value.ToString();
            }
            //https://stackoverflow.com/questions/22998847/wcf-protectionlevel
        }
    }
}
