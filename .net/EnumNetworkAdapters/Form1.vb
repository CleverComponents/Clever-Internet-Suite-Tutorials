Imports System
Imports System.Net

Public Class Form1
    Inherits System.Windows.Forms.Form

#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call

    End Sub

    'Form overrides dispose to clean up the component list.
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents ListBox1 As System.Windows.Forms.ListBox
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.Button1 = New System.Windows.Forms.Button
        Me.ListBox1 = New System.Windows.Forms.ListBox
        Me.SuspendLayout()
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(32, 16)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(75, 23)
        Me.Button1.TabIndex = 0
        Me.Button1.Text = "Go"
        '
        'ListBox1
        '
        Me.ListBox1.Location = New System.Drawing.Point(0, 48)
        Me.ListBox1.Name = "ListBox1"
        Me.ListBox1.Size = New System.Drawing.Size(296, 225)
        Me.ListBox1.TabIndex = 1
        '
        'Form1
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.ClientSize = New System.Drawing.Size(292, 266)
        Me.Controls.Add(Me.ListBox1)
        Me.Controls.Add(Me.Button1)
        Me.Name = "Form1"
        Me.Text = "Enum Network Adapters"
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim strMachineName As String

        'Get the Host Name
        strMachineName = Dns.GetHostName()
        '        Console.WriteLine("Host Name: " + strMachineName)

        'Get the Host by Name
        Dim ipHost As IPHostEntry
        ipHost = Dns.GetHostEntry(strMachineName)

        'You can also query the DNS database for info on a 
        'website like www.microsoft.com
        'In that case replace the above line as:
        'ipHost = Dns.GetHostByName("www.microsoft.com")

        'Get the list of addresses associated with the host in an array
        Dim ipAddr() As IPAddress = ipHost.AddressList
        Dim count As Integer

        ListBox1.Items.Clear()
        'Enumerate the IP Addresses
        Dim addr As IPAddress

        For count = 0 To ipAddr.GetUpperBound(0)
            addr = ipAddr(count)
            ListBox1.Items.Add(String.Format("IP Addresses {0}: {1}", count, addr.ToString))
        Next
    End Sub
End Class
