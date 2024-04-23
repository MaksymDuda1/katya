using MovieGuide.Enums;
using MovieGuide.Models;
using MovieGuide.Services;
using MySql.Data.MySqlClient;
using System.Data.SqlClient;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace MovieGuide
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            GetAllMovies();
            PopulateGenresCheckboxes();
            ExitButton.Visibility = Visibility.Hidden;
        }

        public MainWindow(string login) {
            InitializeComponent();
            GetAllMovies();
            PopulateGenresCheckboxes();
            userLogin = login;
            LoginButton.Visibility = Visibility.Hidden;
            RegistrationButton.Visibility = Visibility.Hidden;
        }
        private string userLogin;

        private void PopulateGenresCheckboxes()
        {
            var genres = Enum.GetValues(typeof(Genre)).Cast<Genre>();

            foreach (var genre in genres)
            {
                var btn = new Button
                {
                    Content = genre.ToString(),
                    Style = (Style)FindResource("StyledButton")
                };
                btn.Click += (sender, e) => GenreButton_Click(sender, e, EnumToValue.ConvertGenreToId(genre));
                GenresPanel.Children.Add(btn);
            }
        }

        private void GenreButton_Click(object sender, RoutedEventArgs e, int genre)
        {
            string connectionString = "Server=localhost;DATABASE=MoviesGuide;UID=root;PASSWORD=1234";
            MySqlConnection conn = new MySqlConnection(connectionString);
            conn.Open();

            string query = "SELECT Movie.*, GROUP_CONCAT(DISTINCT Director.fullname) AS fullname " +
                "FROM Movie " +
                "LEFT JOIN MovieDirector ON Movie.Id = MovieDirector.Movie_Id " +
                "LEFT JOIN Director ON Director.Id = MovieDirector.Director_Id " +
                "WHERE Movie.genre = @genre " +
                "GROUP BY Movie.Id";


            MySqlCommand cmd = new MySqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@genre", genre);
            using (MySqlDataReader data = cmd.ExecuteReader())
            {
                var moviesByGenre = new List<Movie>();
                while (data.Read())
                {
                    var movie = new Movie()
                    {
                        Id = Convert.ToInt32(data["Id"]),
                        Name = data["Name"].ToString(),
                        YearOfEdition = Convert.ToInt32(data["YearOfEdition"]),
                        Description = data["Description"].ToString(),
                        Rate = Convert.ToSingle(data["Rate"]),
                        CoverImage = data["CoverImage"].ToString(),
                        Genre = (Genre)Convert.ToInt32(data["Genre"]),
                    };

                    var directors = data["fullname"].ToString().Split(',').ToList();
                    movie.Directors = new List<string>();
                    foreach (var director in directors)
                    {
                        movie.Directors.Add(director.Trim());
                    }

                    movie.CoverImage = @"D:\wpf\MovieGuide\MovieGuide\Images\" + movie.CoverImage;
                    moviesByGenre.Add(movie);
                }

                moviesListBox.ItemsSource = moviesByGenre;

                moviesByGenre.Clear();
            }
        }


        private void LoginButton_Click(object sender, RoutedEventArgs e)
        {
            var l = new Login();
            this.Close();
            l.Show();
        }

        private void RegistrationButton_Click(object sender, RoutedEventArgs e)
        {
            var r = new Registration();
            this.Close();
            r.Show();
        }

        private void ExitButton_Click(object sender, RoutedEventArgs e)
        {
            userLogin = string.Empty;
            var l = new Login();
            this.Close();
            l.Show();
        }

        private void FavoriteMoviesButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(userLogin))
            {
                MessageBox.Show("Please sign in to access your favorite movies.", "Error", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            var f = new FavoriteMovies(userLogin);
            this.Close();
            f.Show();
        }

        private void GetAllMovies()
        {
            string connectionString = "Server=localhost;DATABASE=MoviesGuide;UID=root;PASSWORD=1234";
            MySqlConnection conn = new MySqlConnection(connectionString);
            conn.Open();

            string query = "SELECT Movie.*, GROUP_CONCAT(Distinct Director.fullname) AS fullname " +
                "FROM Movie LEFT JOIN MovieDirector ON Movie.Id = MovieDirector.Movie_Id " +
                "LEFT JOIN Director ON Director.Id = MovieDirector.Director_Id " +
                "GROUP BY Movie.Id";

            MySqlCommand cmd = new MySqlCommand(query, conn);

            using (MySqlDataReader data = cmd.ExecuteReader())
            {
                var movies = new List<Movie>();
                while (data.Read())
                {
                    var movie = new Movie()
                    {
                        Id = Convert.ToInt32(data["Id"]),
                        Name = data["Name"].ToString(),
                        YearOfEdition = Convert.ToInt32(data["YearOfEdition"]),
                        Description = data["Description"].ToString(),
                        Rate = Convert.ToSingle(data["Rate"]),
                        CoverImage = data["CoverImage"].ToString(),
                        Genre = (Genre)Convert.ToInt32(data["Genre"]),
                    };

                    var directors = data["fullname"].ToString().Split(',').ToList();
                    movie.Directors = new List<string>();
                    foreach (var director in directors)
                    {
                        movie.Directors.Add(director.Trim());
                    }


                    movie.CoverImage = @"D:\wpf\MovieGuide\MovieGuide\Images\" + movie.CoverImage;
                    movies.Add(movie);
                }
                    moviesListBox.ItemsSource = movies;
            }
        }

        private void moviesListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (moviesListBox.SelectedItem is Movie selectedMovie)
            { 
                MovieDetailsPage movieDetailsPage = new MovieDetailsPage(selectedMovie, userLogin);
                this.Close();
                movieDetailsPage.Show();
            }
        }
    }
}