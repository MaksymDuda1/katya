using MovieGuide.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MovieGuide.Models
{
    public class Movie
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public int YearOfEdition { get; set; }      
        public string Description { get; set; } = null!;
        public float Rate { get; set; }
        public string CoverImage { get; set; } = null!;
        public Genre Genre { get; set; }
        public List<string> Directors { get; set; } = new();
        public List<string> Images { get; set; } = new();
    }
}
