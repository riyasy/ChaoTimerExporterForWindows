using System;
using System.IO;
using System.Windows;

namespace PListXMLReaderForChaoTimer
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void button_Click(object sender, RoutedEventArgs e)
        {
            if (!System.IO.Directory.Exists(textBox.Text))
            {
                MessageBox.Show("Enter a valid directory");
                return;
            }

            string line;
            string[] files = Directory.GetFiles(textBox.Text, "*.txt", SearchOption.AllDirectories);

            using (System.IO.StreamWriter resultFile = new System.IO.StreamWriter(textBox.Text + @"\result.csv"))
            {
                foreach (string file in files)
                {
                    if (file == (textBox.Text + @"\result.csv"))
                    {
                        continue;
                    }
                    // Read the file and display it line by line.  
                    System.IO.StreamReader fs =
                        new System.IO.StreamReader(file);
                    bool savenextline = false;
                    string LHS = "";
                    string threeInOne = "";
                    while ((line = fs.ReadLine()) != null)
                    {
                        if (line.Contains(@"<key>NS.string</key>") ||
                            line.Contains(@"<key>NS.time</key>") ||
                            line.Contains(@"<key>timeBeforePenalty</key>"))
                        {
                            LHS = line.TrimStart().Replace(@"<key>", "").Replace(@"</key>", "");
                            LHS = LHS.Replace("NS.time", "TimeOfSolve").Replace("NS.string", "Scramble");
                            savenextline = true;
                        }
                        else
                        {
                            if (savenextline)
                            {
                                String RHS = line.TrimStart().Replace(@"<real>", "").Replace(@"</real>", "").
                                    Replace(@"<string>", "").Replace(@"</string>", "").
                                    Replace(@"<integer>", "").Replace(@"</integer>", "");
                                if (LHS == "TimeOfSolve")
                                {
                                    double seconds = Convert.ToDouble(RHS);
                                    DateTime centuryBegin = new DateTime(2001, 1, 1);
                                    centuryBegin = centuryBegin.AddSeconds(seconds);
                                    RHS = centuryBegin.ToString("yyyy/MM/dd") + "," + centuryBegin.ToString("HH:mm:ss");
                                }

                                threeInOne += ("," + LHS + "," + RHS);
                                savenextline = false;
                                if (LHS == "Scramble")
                                {
                                    resultFile.WriteLine(threeInOne);
                                    threeInOne = "";
                                }
                                LHS = "";
                            }
                        }
                    }
                    fs.Close();
                }
            }
            MessageBox.Show("Success");
        }
    }
}
