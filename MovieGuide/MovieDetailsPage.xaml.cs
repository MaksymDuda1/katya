using MovieGuide.Enums;
using MovieGuide.Models;
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
using static Org.BouncyCastle.Crypto.Engines.SM2Engine;

namespace MovieGuide
{
    /// <summary>
    /// Interaction logic for MovieDetailsPage.xaml
    /// </summary>
    public partial class MovieDetailsPage : Window
    {
        private Movie selectedMovie;

        public MovieDetailsPage(Movie movie, string login)
        {
            InitializeComponent();
            selectedMovie = movie;
            GetImages();
            BindMovieDetails();
            this.login = login;
        }

        string login = "";

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            if (login == null)
            {
                var main = new MainWindow();
                this.Close();
                main.Show();
            }
            else
            {
                var main = new MainWindow(login);
                this.Close();
                main.Show();
            }
        }

        private void BindMovieDetails()
        {
            nameTextBlock.Text = selectedMovie.Name;
            yearTextBlock.Text = selectedMovie.YearOfEdition.ToString();
            descriptionTextBlock.Text = selectedMovie.Description;
            rateTextBlock.Text = selectedMovie.Rate.ToString();
            genreTextBlock.Text = selectedMovie.Genre.ToString();
            coverImageControl.Source = new BitmapImage(new Uri(selectedMovie.CoverImage));
            if (selectedMovie != null && selectedMovie.Images != null)
            {
                List<BitmapImage> bitmapImages = new List<BitmapImage>();

                foreach (string imagePath in selectedMovie.Images)
                {
                    try
                    {
                        BitmapImage bitmapImage = new BitmapImage();
                        bitmapImage.BeginInit();
                        bitmapImage.UriSource = new Uri(imagePath, UriKind.Absolute);
                        bitmapImage.CacheOption = BitmapCacheOption.OnLoad;
                        bitmapImage.EndInit();

                        bitmapImages.Add(bitmapImage);
                    }
                    catch (Exception ex)
                    {
                        // Handle any exceptions that may occur when loading the image
                        MessageBox.Show($"Error loading image: {ex.Message}");
                    }
                }

                imagesListBox.ItemsSource = bitmapImages;
            }
            else
            {
                imagesListBox.ItemsSource = null;
            }
            directorsListBox.ItemsSource = selectedMovie.Directors;
        }

        private void GetImages() {
            string connectionString = "Server=localhost;DATABASE=MoviesGuide;UID=root;PASSWORD=1234";

            if (selectedMovie != null && selectedMovie.Id > 0)
            {
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    try
                    {
                        conn.Open();
                        string query = "SELECT * FROM Image WHERE Movie_Id = @movie_id";
                        MySqlCommand userCmd = new MySqlCommand(query, conn);
                        userCmd.Parameters.AddWithValue("@movie_id", selectedMovie.Id);

                        using (MySqlDataReader data = userCmd.ExecuteReader())
                        {
                            while (data.Read())
                            {
                                string imagePath = data["path"]?.ToString();
                                if (!string.IsNullOrEmpty(imagePath))

                                {
                                    selectedMovie.Images.Add(@"D:\wpf\MovieGuide\MovieGuide\Images\" + imagePath);
                                }
                            }
                        }
                    }
                    catch (MySqlException ex)
                    {
                        MessageBox.Show("Error: " + ex.Message);
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
            }
            else
            {
                MessageBox.Show("Please select a valid movie first.");
            }
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            string connectionString = "Server=localhost;DATABASE=MoviesGuide;UID=root;PASSWORD=1234";

            if (selectedMovie != null && selectedMovie.Id > 0)
            {
                if (string.IsNullOrEmpty(login))
                {
                    MessageBox.Show("Please sign in to add the movie to your favorites.");
                    return;
                }

                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    try
                    {
                        conn.Open();
                        string query = "SELECT Id FROM users WHERE Login = @login";
                        MySqlCommand userCmd = new MySqlCommand(query, conn);
                        userCmd.Parameters.AddWithValue("@login", login);

                        string userId = null;
                        using (MySqlDataReader reader = userCmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                userId = reader["Id"].ToString();
                            }
                        }

                        if (!string.IsNullOrEmpty(userId))
                        {
                            string addQuery = "INSERT INTO UserMovie (User_Id, Movie_Id) VALUES (@userId, @movieId)";
                            MySqlCommand addCmd = new MySqlCommand(addQuery, conn);
                            addCmd.Parameters.AddWithValue("@userId", userId);
                            addCmd.Parameters.AddWithValue("@movieId", selectedMovie.Id);

                            int rowsAffected = addCmd.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                MessageBox.Show("Movie added to your favorites.");
                            }
                            else
                            {
                                MessageBox.Show("Failed to add the movie to your favorites.");
                            }
                        }
                        else
                        {
                            MessageBox.Show("Invalid user login.");
                        }
                    }
                    catch (MySqlException ex)
                    {
                        MessageBox.Show("Error: " + ex.Message);
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
            }
            else
            {
                MessageBox.Show("Please select a valid movie first.");
            }
        }
    }
}
