using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace MovieGuide
{
    /// <summary>
    /// Interaction logic for Login.xaml
    /// </summary>
    public partial class Login : Window
    {
        public Login()
        {
            InitializeComponent();
        }

        private void Login_Click(object sender, RoutedEventArgs e)
        {
            var login = txtLogin.Text;
            var password = txtPassword.Password;

            if (!(login.Length >= 8 && password.Length >= 8)) {
                MessageBox.Show("The length of the login and password must be at least 8");
                return;
            }

            string connectionString = "Server=localhost;DATABASE=MoviesGuide;UID=root;PASSWORD=1234";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    string query = "SELECT * FROM Users WHERE Login = @login AND Password = @password";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@login", login);
                    cmd.Parameters.AddWithValue("@password", password);

                    using (MySqlDataReader data = cmd.ExecuteReader())
                    {
                        if (data.Read())
                        {
                            MessageBox.Show("Login successful!");
                            MainWindow mainWindow = new MainWindow(login);
                            mainWindow.Show();
                            this.Close();
                        }
                        else
                        {
                            MessageBox.Show("Incorrect login or password!");
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("An error occurred: " + ex.Message);
                }
            }
        }
        private void GoToRegister_Click(object sender, MouseButtonEventArgs e)
        {
            var r = new Registration();
            this.Close();
            r.Show();
        }
    }
}
