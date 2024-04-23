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
    /// Interaction logic for Registration.xaml
    /// </summary>
    public partial class Registration : Window
    {
        public Registration()
        {
            InitializeComponent();
        }

        private void Registration_Click(object sender, RoutedEventArgs e)
        {
            var username = txtUsername.Text;
            var login = txtLogin.Text;
            var password = txtPassword.Password;

            if (!(login.Length >= 8 && password.Length >= 8))
            {
                MessageBox.Show("The length of the login and password must be at least 8");
                return;
            }

            string connectionString = "Server=localhost;DATABASE=MoviesGuide;UID=root;PASSWORD=1234";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    string query = "SELECT * FROM Users WHERE Login = @login";
                    MySqlCommand checkCmd = new MySqlCommand(query, conn);
                    checkCmd.Parameters.AddWithValue("@login", login);

                    using (MySqlDataReader data = checkCmd.ExecuteReader())
                    {
                        if (data.Read())
                        {
                            MessageBox.Show("User already exists!");
                            return;
                        }
                    }

                    string addQuery = "INSERT INTO Users (Username, Login, Password) VALUES (@username, @login, @password)";
                    MySqlCommand addCmd = new MySqlCommand(addQuery, conn);
                    addCmd.Parameters.AddWithValue("@username", username);
                    addCmd.Parameters.AddWithValue("@login", login);
                    addCmd.Parameters.AddWithValue("@password", password);

                    int rowsAffected = addCmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        MessageBox.Show("Registration successful!");
                        var main = new MainWindow(login);
                        this.Close();
                        main.Show();
                        
                    }
                    else
                    {
                        MessageBox.Show("Registration failed!");
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("An error occurred: " + ex.Message);
                }
            }
        }

        private void GoToLogin_Click(object sender, MouseButtonEventArgs e)
        {
            var l = new Login();
            this.Close();
            l.Show();
        }
    }
}