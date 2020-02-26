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
            switch (cbSecurity.SelectedIndex)
            {
                case 0:
                    RestSoap.RestSoapClient client = new RestSoap.RestSoapClient();
                    RestSoap.Temperature cels = new RestSoap.Temperature();

                    cels.Units = "C";
                    cels.Value = Convert.ToDouble(edtCelsium.Text);

                    RestSoap.Temperature fahr = client.Celsius2Fahrenheit(cels);

                    edtFahr.Text = fahr.Value.ToString();
                    break;
                case 1:
                    RestSoapSign.RestSoapSignClient clientSign = new RestSoapSign.RestSoapSignClient();
                    RestSoapSign.Temperature celsSign = new RestSoapSign.Temperature();

                    celsSign.Units = "C";
                    celsSign.Value = Convert.ToDouble(edtCelsium.Text);

                    RestSoapSign.Temperature fahrSign = clientSign.Celsius2Fahrenheit(celsSign);

                    edtFahr.Text = fahrSign.Value.ToString();
                    break;
                case 2:
                    RestSoapSignEncrypt.RestSoapSignEncryptClient clientEncrypt = new RestSoapSignEncrypt.RestSoapSignEncryptClient();
                    RestSoapSignEncrypt.Temperature celsEncrypt = new RestSoapSignEncrypt.Temperature();

                    celsEncrypt.Units = "C";
                    celsEncrypt.Value = Convert.ToDouble(edtCelsium.Text);

                    RestSoapSignEncrypt.Temperature fahrEncrypt = clientEncrypt.Celsius2Fahrenheit(celsEncrypt);

                    edtFahr.Text = fahrEncrypt.Value.ToString();
                    break;
            }
        }
    }
}
