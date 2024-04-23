using MovieGuide.Enums;
using MovieGuide.Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace MovieGuide
{
    /// <summary>
    /// Interaction logic for FavoriteMovies.xaml
    /// </summary>
    public partial class FavoriteMovies : Window
    {
        public FavoriteMovies(string userLogin)
        {
            InitializeComponent();
            this.login = userLogin;
            GetFavoriteMovies();

        }

        private string login;
        private List<Movie> favoriteMovies = new List<Movie>();

        private void GetFavoriteMovies()
        {
            string connectionString = "Server=localhost;DATABASE=MoviesGuide;UID=root;PASSWORD=1234";

            if (string.IsNullOrEmpty(login))
            {
                MessageBox.Show("Please sign in to view your favorite movies.", "Error", MessageBoxButton.OK, MessageBoxImage.Warning);
                var mw = new MainWindow();
                this.Close();
                mw.Show();
            }

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT Id FROM Users WHERE Login = @login";
                    MySqlCommand userCmd = new MySqlCommand(query, conn);
                    userCmd.Parameters.AddWithValue("@login", login);

                    int? userId = null;
                    using (MySqlDataReader reader = userCmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            userId = reader.GetInt32("Id");
                        }
                    }

                    if (userId.HasValue)
                    {
                        string getFavoritesQuery = @"
                            SELECT Movie.*, GROUP_CONCAT(DISTINCT Director.fullname) as fullname
                            FROM Movie
                            LEFT JOIN MovieDirector ON Movie.Id = MovieDirector.Movie_Id
                            LEFT JOIN Director ON Director.Id = MovieDirector.Director_Id
                            INNER JOIN UserMovie ON Movie.Id = UserMovie.Movie_Id
                            WHERE UserMovie.User_Id = @userId
                            GROUP BY Movie.Id";


                        MySqlCommand cmd = new MySqlCommand(getFavoritesQuery, conn);
                        cmd.Parameters.AddWithValue("@userId", userId.Value);

                        using (MySqlDataReader data = cmd.ExecuteReader())
                        {
                            favoriteMovies.Clear();
                            while (data.Read())
                            {
                                // Check if the data reader has rows
                                if (data.HasRows)
                                {
                                    var movie = new Movie()
                                    {
                                        Id = data.GetInt32("Id"),
                                        Name = data.GetString("Name"),
                                        YearOfEdition = data.GetInt32("YearOfEdition"),
                                        Description = data.GetString("Description"),
                                        Rate = data.GetFloat("Rate"),
                                        CoverImage = data.GetString("CoverImage"),
                                        Genre = (Genre)data.GetInt32("Genre"),
                                    };

                                    var directors = data["fullname"].ToString().Split(',').ToList();
                                    movie.Directors = new List<string>();
                                    foreach (var director in directors)
                                    {
                                        movie.Directors.Add(director.Trim());
                                    }

                                    movie.CoverImage = @"D:\wpf\MovieGuide\MovieGuide\Images\" + movie.CoverImage;
                                    favoriteMovies.Add(movie);
                                }
                                else
                                {
                                    MessageBox.Show("No favorite movies found for this user.");
                                }
                            }
                        }
                        moviesListBox.ItemsSource = favoriteMovies;
                    }
                    else
                    {
                        MessageBox.Show("Invalid user login.", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"An error occurred: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            var main = new MainWindow(login);
            this.Close();
            main.Show();
        }
    }
}
